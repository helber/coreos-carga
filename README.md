Sistema de cluster utilizando Coreos com boot via PXE
=====================================================

Foi realizado um estudo para criar um teste de carga para um sistema web single page application. Uma característica deste sistema web é uma enorme iteratividade do usuário final com a pagina e uma grande troca de informações entre o servidor web e o cliente (web browser). Boa parte das trocas de informação com o servidor web é mediado por um servidor de websocket, que mantêm a conexão com o browser, e fica interagindo com trocas de mensagens através de websockets. Uma outra característica é que o código da aplicação está em constante evolução e com aplicativos plugáveis, mudando constantemente os tipos de requisição para o servidor.
Com uma aplicação com estas características é difícil criar testes de carga baseados em logs do servidor e automatizar os processos somente pela requisição, pois é necessário delays nas requisições e conexões persistentes por parte dos clientes, para que o teste de carga fique o mais próximo possível do real.
Para se ter uma característica real a solução encontrada foi levantar diversas instancias de browser reais com a aplicação verdadeira carregada neste, e um código adicional para simular as interações do usuário final.
O novo desafio foi então como levantar uma grande quantidade de instancias de navegador apontando para um servidor a ser testado com muitos parâmetros de teste diferentes.
A solução encontrada foi executar as instancias de navegador dentro de linux containers (LXC) utilizando Docker [1] para facilitar a manipulação destes containers.
Como sistema operacional de base para rodar o Docker foi utilizado Coreos [2], e o controle de processos distribuídos foi feito utilizando-se das aplicações etcd[3], que é um banco de dados do tipo chave valor distribuído e tolerante à falha. Dentro das maquinas trabalhadoras onde rodam os containers, o controle das instancias de containers é controlado pela aplicação fleet[4], que lê as informações do banco de dados etcd e executa as tarefas pendentes.
A submissão de tarefas é feita utilizando o aplicativo em linha de comando fleetctl, que faz parte da aplicação fleet.
A descrição de cada container que roda dentro do cluster é feita utilizando UnitFiles da aplicações linux de inicialização do sistema operacional (systemd[5]).
Para facilitar a agregação de maquinas ao cluster, foi empregado o uso de boot via PXE[6], para que uma maquina sem nada instalado se inicie e já inicie como um nó do cluster, e após sua inicialização já esteja pronta para receber tarefas.
O cluster foi criado com o objetivo de realizar testes de carga para uma aplicação específica, mas é de uso genérico, servindo para levantar qualquer tipo de aplicação utilizando Docker, como bancos de dados, servidores web, etc.
Uma característica de como foi projetado o coreos com as aplicações que o compõe, é de ser tolerante à falha. O fleet detecta que nó do cluster caiu, imediatamente outros nós distribuem os containers que estavam rodando no nó que caiu.

[1] - https://coreos.com/
[2] - https://www.docker.com/
[3] - https://github.com/coreos/etcd
[4] - https://github.com/coreos/fleet
[5] – systemd
[6] - PXE
