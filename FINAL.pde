//OBS: Toda vez que aparecer o termo "Meteoro" ou "Nave", eles são intercambiaveis por "Bola" e "Raquete", respectivamente.
//Para que os arquivos de som funcionem é necessário importar a biblioteca Sound do Processing

import processing.sound.*; //comando da biblioteca de som do Processing

SoundFile arcadeMusic;
boolean estaTocandoArcade = false; //variável utilizada para evitar as repetições dos sons dentro do comando "draw"
SoundFile arquivoxMusic;
boolean estaTocandoArquivox = false; //variável utilizada para evitar as repetições dos sons dentro do comando "draw"

float xBola, yBola, moveX, moveY, diam;
float velocX = 5, velocY = 5; // Variáveis da velocidade inicial da bolinha
float xRaqInf, yRaqInf; 
float larguraRaqInf, alturaRaqInf;
float xPowerup, yPowerup, movePWY, diamPW, textPW;
float xPowerup2, yPowerup2, movePWY2, diamPW2;
float xPowerup3, yPowerup3, movePWY3, diamPW3;

int tela = 1;
int pontos = 0;
int rebatidas = 0;
int cordenave = 0;
int life = 3;// Variável que define o número de vidas do jogador

boolean efeito1, efeito2; //Mostram se efeitos estão ativos

//Armazena as imagens presentes no jogo
PImage navevermelha, navevermelhaesquerda, navevermelhadireita; 
PImage naveverde, naveverdeesquerda, naveverdedireita; 
PImage naveciano, navecianoesquerda, navecianodireita; 
PImage fundo1, capa, meteoro, start, startselecionado, cursor, menu, menuselecionado, retry, retryselecionado, starImagem; 
PImage vidaImagem;
PImage star, PWBola, PWRaq;

// FUNÇÕES PARA A VELOCIDADE DA BOLA
/** (RE)INICIAÇÃO DA VELOCIDADE
    DA BOLINHA*/
    
float inicVelocX (float v_x) {
  v_x = random (-1, 1);
  if (v_x < 0) {
    v_x = -velocX;
  } else {
    v_x = velocX;
  }
  return v_x;
}

float inicVelocY (float v_y) {
  v_y = random (-1, 1);
  if (moveY < 0) {
    v_y = -velocY;
  } else {
    v_y = velocY;
  }
  return v_y;
}

void setup () {
  //Faz o setup do tamanho da tela e tira cursor
  size (1000, 1000);
  noCursor();
  
  // CARREGAMENTOS DE IMAGENS
  // Carrega imagens das naves 
  navevermelha = loadImage("Navezinha Vermelha Sem Fogo.png");
  navevermelhadireita = loadImage("Navezinha Vermelha fogo lado direito.png");
  navevermelhaesquerda = loadImage("Navezinha Vermelha fogo lado esquerdo.png");
  naveverde = loadImage("Navezinha verde sem fogo.png");
  naveverdeesquerda = loadImage("Navezinha verde fogo lado esquerdo.png");
  naveverdedireita = loadImage("Navezinha verde fogo lado direito.png");
  naveciano = loadImage("Navezinha Ciano sem fogo.png");
  navecianoesquerda = loadImage("Navezinha Ciano fogo lado esquerdo.png");
  navecianodireita = loadImage("Navezinha Ciano fogo lado direito.png");
  
  // Carrega o restante das imagens do jogo
  fundo1 = loadImage("fundo-1.png");
  capa = loadImage("Capa.png");
  meteoro = loadImage("Meteorito.png");
  start = loadImage("Botão Start.png");
  startselecionado = loadImage("Botão Start Selecionado.png");
  cursor = loadImage("Mouse Personalizado.png");
  menu = loadImage("Menu.png");
  retry = loadImage("Retry.png");
  retryselecionado = loadImage("Retry Selecionado.png");
  menuselecionado = loadImage("Menu Selecionado.png");
  vidaImagem = loadImage ("vida.png");
  starImagem = loadImage ("Star.png");
  PWBola = loadImage ("powerupruim.png");
  PWRaq = loadImage ("powerupruim2.png");
  
  /** INICIALIZAÇÃO DO POSICIONAMENTO DA BOLA */
  xBola = random(width);
  yBola = random(height/2);

  // INICIALIZAÇÕES DE VELOCIDADE
  moveX = inicVelocX (moveX);
  moveY = inicVelocY (moveY);

  // INICIALIZAÇÕES DA RAQUETE E DA BOLA
  //Diâmetro da bola
  diam = 30;
  //Parâmetros da raquete
  larguraRaqInf=200;
  alturaRaqInf=50;
  //Posicionamento da raquete
  xRaqInf = width/2; //onde começa ordenada da raquete inferior (posição x)
  yRaqInf = height-alturaRaqInf/2; //onde começa abscissa da raquete inferior (posição y)
  
  //Muda localização dos parâmetros da funções rect() e image() para o centro
  rectMode (CENTER);
  imageMode (CENTER); 

  //Carrega as trilhas de audio de dentro da pasta "data"
  arquivoxMusic = new SoundFile(this, "arquivox1.mp3");
  arcadeMusic = new SoundFile(this, "arcade.mp3");
 
  vidaImagem = loadImage ("vida.png");

// POWER UPS - INICIALIZAÇÃO 
  //POWER UP 1: DIMININUIR BOLA
  diamPW = 50;
  xPowerup =random(50,900); 
  yPowerup =-diamPW;
  movePWY = random (1, 10);
  //POWER UP 2: LARGURA DO PAD
  diamPW2 = 50;
  xPowerup2 =random(50,900); 
  yPowerup2 =-diamPW2;
  movePWY2 = random (2, 8);
  //POWER UP 3: MULTIPLICAR PONTOS
  diamPW3= 30;
  xPowerup3 =random(50,900); 
  yPowerup3 =-diamPW3;
  movePWY3= random (1, 5);
  //inicializa o texto indicativo do power-up
  textPW = 0;
}

void draw () {
  
  // Muda as músicas de acordo com a tela
  if (tela == 1 && estaTocandoArquivox == false) {
    arquivoxMusic.loop();
    estaTocandoArquivox = true;
    arcadeMusic.stop();
    estaTocandoArcade = false;
  }
  if (tela == 2 && estaTocandoArquivox == false) {
    arquivoxMusic.loop();
    estaTocandoArquivox = true;
    arcadeMusic.stop();
    estaTocandoArcade = false;
  }
  if (tela == 3 && estaTocandoArcade == false) {
  arcadeMusic.loop();
  estaTocandoArcade = true;
  arquivoxMusic.stop();
  estaTocandoArquivox = false;
  }
  if (tela == 4 && estaTocandoArquivox == false) {
  arquivoxMusic.loop();
  estaTocandoArquivox = true;
  arcadeMusic.stop();
  estaTocandoArcade = false;
  }
  
  //Carrega fonte personalizada
  PFont myFont;
  myFont = createFont("Pixels.ttf", 64);
  textFont(myFont);

  // Variável que mostra o tamanho do "propulsor" na nave,
  int propulsor = 50;
  // pensada só a fim de facilitar contas. Por causa dele, a
  // largura da imagem =/= da área que a bola encosta do retângulo.

// ------------------------------------------------ TELA INICIAL ------------------------------------------------
if (tela == 1) {
  
  //Carrega os elementos básicos da tela
  background (122);
  image (fundo1, width/2, height/2, width, height);
  image (capa, width/2, height/2-100, 620, 620);
  image (start, width/2, height/2+350, 360, 90);
  
  //Faz o botão de start funcionar de forma devida, além de fazer uma borda amarela aparecer quando passa mouse por cima
  if (mouseX < width/2 + 180 && mouseX > width/2 - 180 && mouseY <height/2+350 +90/2 && mouseY > height/2+350 -90/2){
  image (startselecionado, width/2, height/2+350, 360, 90);
  if (mousePressed == true && (mouseButton == LEFT)){  
    tela = 2;
    life = 3;
}
}
  //Carrega cursor personalizado
  image (cursor, mouseX, mouseY, 30, 130/3);
}

// ------------------------------------------ TELA DE SELEÇÃO DE NAVE -------------------------------------------
if (tela == 2) {
  
    //Carrega todos os elementos gráficos dispostos
    image (fundo1, width/2, height/2, width, height);
    fill(255,255,0);
    textSize(160);
    textAlign(CENTER);
    
    //Opções de selecção de nave
    text ("choose your starship", width/2, 250);
    image (navevermelha, width/2, height/2-150, 2*larguraRaqInf + propulsor*2, 2*alturaRaqInf);
    image (naveverde, width/2, height/2, 2*larguraRaqInf + propulsor*2, 2*alturaRaqInf);
    image (naveciano, width/2, height/2+150, 2*larguraRaqInf + propulsor*2, 2*alturaRaqInf);
    
    //Sequência de interações que permitem definir qual nave o jogador irá utilizar, além de passar para próxima tela
    if (mousePressed == true && (mouseButton == LEFT) && mouseX > width/2-larguraRaqInf && mouseX < width/2+larguraRaqInf && mouseY < height/2 - 150 + alturaRaqInf && mouseY > height/2 -150 - alturaRaqInf){
    cordenave = 1;
    tela = 3;
    }
    if (mousePressed == true && (mouseButton == LEFT) && mouseX > width/2-larguraRaqInf && mouseX < width/2+larguraRaqInf && mouseY < height/2 + alturaRaqInf && mouseY > height/2 - alturaRaqInf){
    cordenave = 2;
    tela = 3;
    }
    if (mousePressed == true && (mouseButton == LEFT) && mouseX > width/2-larguraRaqInf && mouseX < width/2+larguraRaqInf && mouseY < height/2+150 + alturaRaqInf && mouseY > height/2+150 - alturaRaqInf){
    cordenave = 3;
    tela = 3;
    }
    
    //Carrega cursor personalizado
    image (cursor, mouseX, mouseY, 30, 130/3);
    }

// --------------------------------------------- TELA DO JOGO EM SI ---------------------------------------------
if (tela == 3) {
  image (fundo1, width/2, height/2, width, height);
  
  //Coloca o placar no topo direito da tela
  fill (255,255,0);
  textSize(100);
  text (pontos, 925, 50);
  
  //Texto de último efeito ativo
  textSize(40);
  textAlign(LEFT);
  text ("Ultimo efeito ativo:", 20, 80);
  
  
  //incrementa a posição x da bolinha com o valor de moveX
  xBola = xBola + moveX;
  //incrementa a posição y da bolinha com o valor de moveY
  yBola = yBola + moveY;

  //Faz a bola rebater quando encosta na parede.
  if (xBola < 0 || xBola > width) {
    moveX = -moveX;
  }
  if (yBola < 0) {
    moveY = -moveY;
  }
  
  //Faz o meteoro voltar ao bater na parte de cima da nave, além de adicionar ponto ao placar
  if (xBola > xRaqInf - larguraRaqInf/2 - diam/2 &&
    xBola < xRaqInf + larguraRaqInf/2 + diam/2 &&
    yBola > height-alturaRaqInf - diam/2) {
    moveY = -moveY;
    rebatidas = rebatidas + 1;
    pontos = pontos + 1;
  }
  
 // ↓↓↓ INSERIR COMANDOS DE FASES AQUI ↓↓↓
 // Fase 1
  if (rebatidas < 5) {
    // Velocidade com valor da inicialização
    // Texto temporário indicador de nova fase
    if (rebatidas < 1) {
      textSize (120);
      textAlign (CENTER);
      text ("NIVEL 1", width/2, 100);
    }
  }
  // Fase 2
  else if (rebatidas < 10) {
    // Mudança da velocidade x da bola
    if (moveX < 0) {  // Se o movimento no eixo x for negativo,
      moveX = -7.5;   // a nova velocidade continuará sendo negativa.
    } else {          // Mas se o movimento no eixo x for positivo.
      moveX = 7.5;    // a nova velocidade será positiva.
    }
    // Mudança da velocidade y da bola
    if (moveY < 0) {  // Se o movimento no eixo y for negativo,
      moveY = -7.5;   // a nova velocidade continuará sendo negativa.
    } else {          // Mas se o movimento no eixo x for positivo.
      moveY = 7.5;    // a nova velocidade será positiva.
    }
    // Texto temporário indicador de nova fase
    if (rebatidas < 6) {
      textSize (120);
      textAlign (CENTER);
      text ("NIVEL 2", width/2, 100);
    }
  }
  // Fase 3
  else if (rebatidas < 15) {
    // Mudança da velocidade x da bola
    if (moveX < 0) {
      moveX = -10;
    } else {
      moveX = 10;
    }
    // Mudança da velocidade y da bola
    if (moveY < 0) {
      moveY = -10;
    } else {
      moveY = 10;
    }
   
    // Texto temporário indicador de nova fase
    if (rebatidas < 11) {
      textSize (120);
      textAlign (CENTER);
      text ("NIVEL 3", width/2, 100);
    }
  }
  // Fase 4
  else if (rebatidas < 30) {
    // Mudança da velocidade x da bola
    if (moveX < 0) {
      moveX = -12.5;
    } else {
      moveX = 12.5;
    }
    // Mudança da velocidade y da bola
    if (moveY < 0) {
      moveY = -12.5;
    } else {
      moveY = 12.5;
    }
    // Texto temporário indicador de nova fase
    if (rebatidas < 16) {
      textSize (120);
      textAlign (CENTER);
      text ("NIVEL 4", width/2, 100);
    }
  }
  // Fase 5
  else {
    // Mudança da velocidade x da bola
    if (moveX < 0) {
      moveX = -15;
    } else {
      moveX = 15;
    }
    // Mudança da velocidade y da bola
    if (moveY < 0) {
      moveY = -15;
    } else {
      moveY = 15;
    }
    // Texto temporário indicador de nova fase
    if (rebatidas < 31) {
      textSize (120);
      textAlign (CENTER);
      text ("NIVEL 5", width/2, 100);
    }
  }

  // POWER UPS - DEFINE OS EFEITOS AO BATER NO PAD
  
  // Power-up 1: Diminuir o tamanho da bola (O que acontece caso rebata)
  if (xPowerup > xRaqInf - larguraRaqInf/2 - diamPW/2 &&
  xPowerup < xRaqInf + larguraRaqInf/2 + diamPW/2 &&
  yPowerup > height-alturaRaqInf - diamPW/2) 
  {
    diam = diam*0.75;
    yPowerup = random(-6000,-3000); //joga o powerup nesse ponto, voltando conforme a velocidade//
    xPowerup = random (diamPW, width -diamPW);
    textPW =1; 
    efeito1 = true;
  }
  
  //O que acontece caso o PW1 saia da tela
  if (yPowerup>height){
  yPowerup = random(-8000, -3000);
  movePWY = random (1, 10);
  }
  
  //Adiciona o texto correspondente ao power-up
  if (textPW == 1)
  {
    textSize(40);
    textAlign(LEFT);
    text ("Diminuir bola", 20, 110);
  }
  
  if (efeito1 == true && yPowerup > 0){
        diam = diam*1.34;
      efeito1 = false;
  }
 
  //POWER-UP 2
  //Diminuir a largura da nave pela metade  
  if (xPowerup2 > xRaqInf - larguraRaqInf/2 - diamPW2/2 &&
  xPowerup2 < xRaqInf + larguraRaqInf/2 + diamPW2/2 &&
  yPowerup2 > height-alturaRaqInf - diamPW2/2) 
  {
    larguraRaqInf = larguraRaqInf * 0.5;
    xPowerup2 = random (diamPW2, width -diamPW2);
    yPowerup2 = random(-6000,-3000); //joga o powerup nesse ponto, voltando conforme a velocidade//
    textPW=2;
    efeito2 = true;
  }
  
  //Quando sai da tela, reseta a posição
  if (yPowerup2>height){
    yPowerup2 = random(-6000,-3000);
    xPowerup2 = random (diamPW2, width -diamPW2);
    movePWY2 = random (2, 8);
  }
  
  // Adiciona o texto correspondente ao power-up
  if (textPW ==2)
  {
    textSize(40);
    textAlign(LEFT);
    text ("Diminuir PAD", 20, 110);
  }
  
  //Faz com que o efeito suma quando a bolinha de powerup aparece novamente
  if (efeito2 == true && yPowerup2 > 0){
    larguraRaqInf= larguraRaqInf * 2;
    efeito2 = false;
  }
  
  //POWER UP 3
  //Multiplica a pontuação
  if (xPowerup3 > xRaqInf - larguraRaqInf/3 - diamPW3/2 &&
  xPowerup3 < xRaqInf + larguraRaqInf/3 + diamPW3/2 &&
  yPowerup3 > height-alturaRaqInf - diamPW3/2) 
  {
    pontos = pontos + 10;
    yPowerup3 = random(-7000,-5000);//joga o powerup nesse ponto, voltando conforme a velocidade//
    textPW =3;
  }
  
  //Quando sai da tela, reseta
  if (yPowerup3>height){
  xPowerup3 = random (diamPW2, width -diamPW2);
  yPowerup3 = random(-6000,-3000);
  movePWY3 = random (2, 10);
  }
  
  // Adiciona o texto correspondente ao power-up
  if (textPW ==3)
  {
    textSize(40);
    textAlign(LEFT);
    text ("+10 PONTOS", 20, 110);
  }
  
  // ATUALIZAÇÃO DO MOSTRADOR DE VIDAS
  for (int i = 0; i < life; i++) {
    image(vidaImagem,30 + i * 30, 30);
  }
  
  if (yBola > height) {
    //Uma vida é perdida, e algumas variáveis são resetadas
    life = life-1;
    // Sorteio da nova posição da bola na tela
    xBola = random(width); 
    yBola = random(height/2);
    // Reinício da velocidade e direção da bola
    moveX = inicVelocX (moveX);
    moveY = inicVelocY (moveY);

    // RESETA - TAMANHO DA BOLA , TAMANHO DA NAVE, E TEXTOS
    diam = 30;
    larguraRaqInf=200;
    alturaRaqInf=50;
    textPW = 0;
  }
  
  //O que acontece caso o jogador perca todas as vidas
  if(life == 0) {
    tela = 4;
    // Sorteio da nova posição da bola na tela
    xBola = random(width); 
    yBola = random(height/2);
    // Reinício da velocidade e direção da bola
    moveX = inicVelocX (moveX);
    moveY = inicVelocY (moveY);
    }

    // desenha meteoro sempre na posição atualizada
    image (meteoro, xBola, yBola, diam, diam);

    // POWER UP - REINICIALIZAÇÃO E ÍNICIO DO MOVIMENTO
    if(pontos>=2) {
    yPowerup = yPowerup + movePWY;
    }
    if(pontos>=5) {
      yPowerup2 = yPowerup2 + movePWY2;
    }
    if(pontos>=10)
    {
      yPowerup3 = yPowerup3 + movePWY3;
    }

    // DESENHO DOS POWER-UPS NA TELA
    //Power-up 1
    image(PWBola, xPowerup, yPowerup, diamPW, diamPW);
    image (PWRaq, xPowerup2, yPowerup2, diamPW2, diamPW2);
    image (starImagem, xPowerup3, yPowerup3, diamPW3, diamPW3);
  
    // CARREGAMENTO DE SPRITES DAS NAVES
    // Carrega os sprites da nave dependendo da escolha feita na tela de seleção
    if (cordenave == 1){
      image (navevermelha ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
      if (keyPressed == true){
         if (key == 'a' || key == 'A'){
         image (navevermelhadireita ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
         }
         if (key == 'd' || key == 'D'){
         image (navevermelhaesquerda ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
        }
      }
    }
    if (cordenave == 2){
      image (naveverde ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
      if (keyPressed == true){
         if (key == 'a' || key == 'A'){
         image (naveverdedireita ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
         }
         if (key == 'd' || key == 'D'){
         image (naveverdeesquerda ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
        }
      }
    }
   if (cordenave == 3){
     image (naveciano ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
     if (keyPressed == true){
        if (key == 'a' || key == 'A'){
        image (navecianodireita ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
        }
        if (key == 'd' || key == 'D'){
        image (navecianoesquerda ,xRaqInf, yRaqInf, larguraRaqInf+propulsor, alturaRaqInf);
        }
      }
    }
  
    /** DEFINIÇÃO DOS MOVIMENTOS DA NAVE
    /** Faz o movimento da nave, além de
    impedir que saia pelas bordas. */
    if (keyPressed == true){
      //Permite movimento livre
      if (xRaqInf >= larguraRaqInf/2 && xRaqInf <= width - larguraRaqInf/2){
        if (key == 'a' || key == 'A'){
        xRaqInf = xRaqInf - 8;
        }
        if (key == 'd' || key == 'D'){
        xRaqInf = xRaqInf + 8;
        }
      }
      else {
       //Proíbe que saia pela borda esquerda
       if (xRaqInf <= larguraRaqInf/2){
         if (key == 'd' || key == 'D'){
         xRaqInf = xRaqInf + 8;
         }
       }
       //Proíbe que saia pela borda direita
       if (xRaqInf >= width - larguraRaqInf/2){
         if (key == 'a' || key == 'A'){
      xRaqInf = xRaqInf - 8;
         }
       }
     }
    } 
  } // Fim dos comandos da Tela 3
  
// --------------------------------------------- TELA DE GAME OVER ----------------------------------------------
if (tela == 4) {
   //Carrega os elementos visuais da tela
   image (fundo1, width/2, height/2, width, height);
   fill(255);
   textAlign(CENTER);
   textSize(100);
   text ("voce defendeu a Terra por:", width/2, 160);
   text ("dias", width/2, 310);
   textSize(200);
   text (pontos, width/2, 250); // Mostra a pontuação que o jogador fez
   image (menu, width/2+225, height/2+200 , 360, 90);
   image (retry, width/2-225, height/2+200 , 360, 90);
   
   //Faz o botão retry se iluminar quando passa o mouse por cima e faz com que possa passar para próxima tela
   if (mouseX < width/2 - 225 + 180 && mouseX > width/2 - 225 - 180 && mouseY <height/2+200 +90/2 && mouseY > height/2+200 -90/2){
     image (retryselecionado, width/2-225, height/2+200 , 360, 90);
     if (mousePressed == true && (mouseButton == LEFT)){ 
       life = 3;
       pontos = 0;
       rebatidas = 0;
       tela = 3;
       xRaqInf = width/2;
       
       //Reinicia mecânica de PowerUps
       diamPW = 50;
       xPowerup =random(50,900); 
       yPowerup =-diamPW;
       movePWY = random (1, 10);
       diamPW2 = 40;
       xPowerup2 =random(50,900); 
       yPowerup2 =-diamPW2;
       movePWY2 = random (2, 8);
       diamPW3= 30;
       xPowerup3 =random(50,900); 
       yPowerup3 =-diamPW3;
       movePWY3= random (1, 5);
       efeito1 = false;
       efeito2 = false;
       textPW = 0;
     }
   }
   
   //Faz o botão menu se iluminar quando passa o mouse por cima e faz com que possa passar para próxima tela 
      if (mouseX < width/2 + 225 + 180 && mouseX > width/2 + 225 - 180 && mouseY <height/2+200 +90/2 && mouseY > height/2+200 -90/2){
      image (menuselecionado, width/2+225, height/2+200 , 360, 90);
        if (mousePressed == true && (mouseButton == LEFT)){
          pontos = 0;
          rebatidas = 0;
          tela = 1;
        
       //Reinicia mecânica de PowerUps
       diamPW = 50;
       xPowerup =random(50,900); 
       yPowerup =-diamPW;
       movePWY = random (1, 10);
       diamPW2 = 40;
       xPowerup2 =random(50,900); 
       yPowerup2 =-diamPW2;
       movePWY2 = random (2, 8);
       diamPW3= 30;
       xPowerup3 =random(50,900); 
       yPowerup3 =-diamPW3;
       movePWY3= random (1, 5);
       efeito1 = false;
       efeito2 = false;
       textPW = 0;

        }
      }
      
  //Carrega cursor personalizado
  image (cursor, mouseX, mouseY, 30, 130/3);
}
}
