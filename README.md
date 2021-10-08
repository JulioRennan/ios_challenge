# IOS Challenge
Desafio proposto pelo **Instituto de Pesquisa Eldolrado**. Consiste em consumir a **API do GitHub**, e extrair informações básicas sobre os repositórios relacionados a linguagem **Swift** e seus respectivos pull requests. Todos os Widgets, foram escolhidos de acordo com sua equivalência na versão nativa do IOS, conforme essa sessão da [documentação do Flutter](https://flutter.dev/docs/get-started/flutter-for/ios-devs#what-is-the-equivalent-to-coredata-in-flutter).


## Direferenciais implementados
- [x] Documentação no código
- [x] Paginação das listas: carregar lista de repositórios por demanda na rolagem da tela
- [ ] Testes (TDD)
- [X] Cancelamento da requisição ao sair da tela onde ela foi chamada.
##
## Instruções de uso
 - Tenha o [**flutter SDK**](https://flutter.dev/docs/get-started/install), instalado em sua máquina.
 - Selecione o Device que será usado para o teste.
 - Clone o repositório e execute o programa via linha de comando com ````flutter run```` na pasta raiz do repositório.
##
## Telas
![Frame 1 (1)](https://user-images.githubusercontent.com/57741609/136555291-f29ec757-7556-4c5c-86a0-dd9987b53beb.png)

## Sobre o uso biblioteca de terceiros
 - [Dio](https://pub.dev/packages/dio): Biblioteca responsável por fazer as chamadas de API, á escolha dessa lib se deu principalmente pela facilidade de implementar interceptores em 3 momentos da requisição: 
    - **onRequest:** chamado antes de realizar a requisição.
    -  **onResponse:** chamado quando o app tiver uma reposta do servidor.
    -  **onError:**. chamado quando acontecer um erro em qualquer etapa anterior.
 ###
 - [GetX](https://pub.dev/packages/get): Biblioteca em que sua principal utilidade é no gerenciamento de estado da aplicação. Possui legibilidade e performance muito boa, permitindo separar bem a lógica das visualizações do app.
 ###
 - [SqFlite](https://pub.dev/packages/sqflite): De acordo com a documentação do flutter, esse seria SGBD mais próximo ao **CoreData** do **IOS**.
##

## Estrutura do projeto (MVC)
Pelo o estilo da programação da UI, não ser declariva, esse padrão deixa um pouco mais simples a análise da parte lógica.

* **/lib**
  * **main.dart:** _ponto de entrada do aplicativo_.   
  * **/model:** _(regras de negócio, comunicação com API e com o Banco de Dados)_.
    * **/dao:** _(classes reponsáveis pela conexão com o banco de dados)_.
    * **/API:** _(classes reponsáveis pela conexão com a API)_.
    * **/Entity:** _(são os objetos que possuem as regras da estrutura das entidades envolvidas na aplicação)_.
    
  * **/view:** _(todas as telas e componentes)_.
    * **/shared_components:** _(componentes globais a toda aplicação)_.
    * **/pull_view:** _(componentes referentes a tela de visualização das pulls requests)_.
      * **/widgets:** _ (componentes utilizados referentes a pull_screen.dart)_.
    * **/repository_view:** _(componentes referentes a tela de listagem de todos os repositórios)_.
       * **/widgets:** _ (componentes utilizados referentes a repository_screen.dart)_.
    * **/home_screen.dart:** _tela inicial do app_. 
  * **/controller**:
    * **/pull_controller:** _classe responsável por gerir as entidades que rerpresentam a pull, com sua respectiva view_.
    * **/repository_controller:** _classe responsável por gerir as entidades que rerpresentam os repositories , com sua respectiva view_.

##

<kbd> <a href="url"><img src="https://media-exp1.licdn.com/dms/image/C4D03AQEET_PIFFi3Bg/profile-displayphoto-shrink_800_800/0/1615702283090?e=1639008000&v=beta&t=FnSTOJ9OX0qWGWezZDCixv1pns4XWeN624yMSL900eo" height="auto" width="50" style="border-radius:50%"></a></kbd>   Feito com ❤️ por **Julio Rennan!** 

[![Linkedin Badge](https://img.shields.io/badge/-Julio-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/julio-souza-4ab63b1aa/)](https://www.linkedin.com/in/julio-souza-4ab63b1aa/) 
  

