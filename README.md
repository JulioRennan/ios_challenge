

![Frame 1 (4)](https://user-images.githubusercontent.com/57741609/136587266-d4b4c043-dcff-452a-9967-ac7e03ea790d.png)



Desafio foi proposto pelo **Instituto de Pesquisas Eldorado**. Consiste em consumir a **API do GitHub** e extrair informações básicas sobre os repositórios relacionados a linguagem **Swift** e seus respectivos pull requests. Todos os Widgets, foram escolhidos de acordo com sua equivalência na versão nativa no IOS, conforme essa sessão da [documentação oficial do Flutter](https://flutter.dev/docs/get-started/flutter-for/ios-devs#what-is-the-equivalent-to-coredata-in-flutter).
### Considerações iniciais:
   * **UISegmentedControl** equivale ao **CupertinoSegmentedControl**.
   * **CollectionView/TableView**  equivale a **ListView**.
   * **Core Data** é equivalente ao **SQFlite**.

##
Tabela de conteúdos
=================
<!--ts-->
   * [Direferenciais implementados](#direferenciais-implementados)
   * [Instruções de Uso](#instruções-de-uso)
   * [Telas](#telas)
   * [Sobre o uso biblioteca de terceiros](#sobre-o-uso-biblioteca-de-terceiros)
   * [Estrutura do projeto (MVC)](#estrutura-do-projeto)
 
<!--te-->

# Direferenciais implementados
- [x] Documentação no código
- [x] Paginação das listas: carregar lista de repositórios por demanda na rolagem da tela
- [ ] Testes (TDD)
- [X] Cancelamento da requisição ao sair da tela onde ela foi chamada.
##
# Instruções de Uso
 - Tenha o [**flutter SDK**](https://flutter.dev/docs/get-started/install), instalado em sua máquina.
 - Selecione o Device que será usado para o teste, recomendo o [**AVD Manager**](https://developer.android.com/studio/run/managing-avds?hl=pt-br) do Android Studio.
 - Clone o repositório e execute o comando ````flutter run```` na pasta raiz do repositório.
##
# Telas
![telas](https://user-images.githubusercontent.com/57741609/136589223-ad32e591-d0d7-4fde-b61a-5a71d4f4861d.png)


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

# Estrutura do projeto
O padrão escolhido foi o **MVC**, para facilitar a comparação da lógica do aplicativo entre a linguagem **Swift**  e o framwerol **Flutter**. 

Pois como o **Flutter**, possui o estilo de UI declarivo é comum que a view e a lógica acabem se tornando levemente acopladas. Tendo isso, as regras de renderização ficaram dentro das classes de **Controllers**, exceto de **Widgets** locais (animações simples e loading de botões). .


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

#

<kbd> <a href="url"><img src="https://media-exp1.licdn.com/dms/image/C4D03AQEET_PIFFi3Bg/profile-displayphoto-shrink_800_800/0/1615702283090?e=1639008000&v=beta&t=FnSTOJ9OX0qWGWezZDCixv1pns4XWeN624yMSL900eo" height="auto" width="50" style="border-radius:50%"></a></kbd>   Feito por: **Julio Rennan!** 

[![Linkedin Badge](https://img.shields.io/badge/-Julio-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/julio-souza-4ab63b1aa/)](https://www.linkedin.com/in/julio-souza-4ab63b1aa/) 
  

