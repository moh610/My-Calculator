import 'package:decimal/decimal.dart';

//fait reference à la dernière valeur tapée par l'utilisateur
String valeurActuelle = '';
// liste des differents nombres tapée par l'utilisateur
List<String> number = [];
String operant = '';
//listes des operant utilisés par l'utilisateur
List<String> lastOperant = [];
var resultat ;
//affiche le calcul en cours
String operation = '';
//avant-dernière valeur tapée par l'utilisateur
String lastVal = '';
//determine la presence du signe de soustraction devant un nombre
bool sub=false;

// definition de la fonction calculatrice qui va nous permettre de faire les differentes operations

void calculatrice(String val) {
  if (val == '+' || val == '-' || val == '÷' || val == 'X' || val=='%'|| val=='=') {
    lastVal=val;

    //ajout des operants dans la liste lastoperant
    val!='='? lastOperant.add(val):lastOperant;

    //pourcentage
    if(lastVal=='%' && number.length==1){
      operation=operation+lastVal;
      resultat = num.parse(number.first) / 100;
    }
    else if(number.length==0){
      operation=='';
    }

    //affiche le resultat finale uniquement quand on appuye sur egal
    else if(lastVal=='=' && number.length>=2){

      operation=resultat.toString();
    }

    //remplace l'operant actuel par un autre si operation.length-1 égale à l'un des operants
    else if((operation[operation.length-1]=="+" && (val=='-' || val=='÷' || val=='X')) ||
        (operation[operation.length-1]=="-" && (val=='+' || val=='÷' || val=='X')) ||
        (operation[operation.length-1]=="X" && (val=='-' || val=='÷' || val=='+')) ||
        (operation[operation.length-1]=="÷" && (val=='-' || val=='+' || val=='X'))){
      operant=val;
      operation=operation.replaceRange(operation.lastIndexOf(operation[operation.length-1]), null,val);
    }

    //enregistrement de l'operant et definition de l'operation
    else {
      valeurActuelle = '';
      operant = val;
      ((operation[operation.length-1]=='+' && val=='+') || (operation[operation.length-1]=='-' && val=='-')||
          (operation[operation.length-1]=='X' && val=='X')||(operation[operation.length-1]=='÷' && val=='÷'))
          || val=='=' ?operation:operation += val;
    }

  }

  // determine la presence du signe - devant le premier nombre
  else if(val=='(-'){
    number.length==0? operation+=val:number.length==1?operation='(-'+operation:operation;
    number.length==0 || number.length==1? sub=true:sub;

  }

  //vide toutes les variables
  else if (val == 'C') {
    number = [];
    operant = '';
    lastOperant = [];
    valeurActuelle = '';
    resultat = 0;
    operation = '';
    sub=false;

  }

  //supprime un nombre à la fois
  else if(val=='AC'){
    print(operation[operation.length-1]);

    //si operation.last = l'un des operants supprime le dernier element de lastOperation
    lastOperant.isNotEmpty && (operation[operation.length - 1] == '+' || operation[operation.length - 1] == '-' ||
        operation[operation.length - 1] == 'X' || operation[operation.length - 1] == '÷'
        || operation[operation.length - 1] == '%') ?
    lastOperant.removeLast():lastOperant;

    // actualise l'operant en fonction de l'Operation
    lastOperant.length>0? operant=lastOperant.last:operant;
    lastVal='';

    //verifie si operation contient le signe devant le premier nombre
    if(operation.contains('(-')){
      sub=true;
    }

    //si operation =! l'un des operants supprime number.last
    if(operation!='' && (operation[operation.length-1]!='+' && operation[operation.length-1]!='-'
        && operation[operation.length-1]!='X' && operation[operation.length-1]!='÷')){

      //condition 1
      if(number.length==2 ) {

        //si number.last correspond == un chiffre
        if(number.last.length==1) {
          number.remove(number.last);
          print(number.length);
          print(number);
        }

        //si number.last > un chiffre
        else{
          String n1=number.last;
          int index=number.lastIndexOf(number.last);
          number[index]=number.last.substring(0,number.last.length-1);
          operant=='X'?resultat=num.parse(number.first)*num.parse(number.last):operant=='÷'?
          resultat=num.parse(number.first)/num.parse(number.last):
          resultat>0?resultat=resultat-(num.parse(n1)-num.parse(number.last)):
          resultat=resultat+ (num.parse(n1)-num.parse(number.last));
        }
      }

      //condition 2
      else if(number.length>2){
        //si numbertlast.last = un chiffre
        if(number.last.length==1){
          //condition 1
          if(operant=='+'){
            if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='X')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='X')) {
              resultat = resultat - num.parse(number.last);
            }
            else {
              resultat = resultat - num.parse(number.last);
            }
          }
          //condition 2
          else if(operant=='-'){
            if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='X')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='X')) {
              resultat = resultat + num.parse(number.last);
            }
            else {
              resultat = resultat + num.parse(number.last);
            }

          }
          //condition 3
          else if(operant=='X'){
            num multiplication=num.parse(number[number.length-2])*num.parse(number.last);
            if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='+')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='+')){
              resultat=resultat-multiplication+num.parse(number[number.length-2]);
            }
            else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='-')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='-')){
              resultat=resultat+multiplication-num.parse(number[number.length-2]);
            }

            else {
              resultat=resultat/num.parse(number.last);
            }
          }
          //condition 4
          else if(operant=='÷'){
            num div = num.parse(number[number.length - 2]) /
                num.parse(number.last);
            if ((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='-')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='-')) {
              num result = resultat + div;
              resultat = result - num.parse(number[number.length - 2]);;
            }
            else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='+')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='+')) {
              num result = resultat - div;
              resultat = result + num.parse(number[number.length - 2]);;
            }
            else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='X')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='X')){
              num produit=num.parse(number[number.length-2])*num.parse(number.last);
              num result=resultat-num.parse(number[number.length-2]);
              resultat=result+produit;
            }

          }
          //supprime number.last
          number.removeLast();
        }
        //si le nombre de caractère de number.last > 1
        else if(number.last.length>1){
          String last_number=number.last;
          int index=number.lastIndexOf(number.last);
          number[index]=number.last.substring(0,number.last.length-1);
          //condition 1
          if(operant=='+'){
            resultat = resultat - (num.parse(last_number)-num.parse(number.last));
          }
          //condition 2
          else if(operant=='-'){
            resultat=resultat+(num.parse(last_number)-num.parse(number.last));
          }
          //condition 3
          else if(operant=='X'){
            if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='+')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='+')){
              num multiplication=num.parse(number[number.length-2])*num.parse(last_number);
              resultat=resultat-multiplication+(num.parse(number[number.length-2])*num.parse(
                  number.last));
            }
            else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='-')
                ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='-')){
              num multiplication=num.parse(number[number.length-2])*num.parse(number.last);
              resultat=resultat+multiplication-(num.parse(number[number.length-2])*num.parse(
                  number.last));
            }
            else{
              resultat=resultat/num.parse(last_number)*num.parse(number.last);
            }
          }
        }
      }

      else if(number.length==1){
        //number.first > 1 chiffre
        if(number[0].length>1){
          int index=number.lastIndexOf(number.last);
          number[index]=number.last.substring(0,number.last.length-1);
        }
      }
    }
    operation.length > 0 ?
    operation = operation.substring(0, operation.length - 1) : operation =
        operation.substring(0, 1);
    if ((operation != '' && operation[operation.length - 1] == '+') || (operation!='' &&
        operation[operation.length - 1] == '-') || (operation!='' && operation[operation.length - 1] == 'X')
        ||(operation!='' && operation[operation.length - 1] == '÷')) {
      lastVal = operation[operation.length - 1];
      //  lastOperant.removeLast();
      print(lastVal);
      //  val1 = operation[operation.length - 1];
    }
    else if(operation==''){
      number=[];
      operant='';
      resultat=0;
      sub=false;
    }


  }


  else {
    //concatenation
    valeurActuelle += val;
    operation += val;

    //add number
    if(number.length==0 || lastVal == '+' || lastVal == '-' || lastVal == '÷' || lastVal == 'X'){
      number.add(val);
      lastVal='';
    }

//ajout des nombre à plus d'un chiffre
    else if(number.length>=1 && val != '+' && val != '-' && val != '÷' && val != 'X' && val!='%'){
      int index=number.lastIndexOf(number.last);
      number[index]=number.last+val;
    }

    if (number.length == 2) {
      //addition
      if (operant == '+') {
        //lastOperant = operant;
        if(lastOperant.length==2 && lastOperant.first=='%'){
          resultat=resultat + num.parse(number[1]);
        }

        else {
          sub == true ?
          resultat = -num.parse(number[0]) + num.parse(number[1]) :
          resultat = num.parse(number[0]) + num.parse(number[1]);
          sub = false;
        }
      }
      //soustraction
      else if (operant == '-') {
        // lastOperant = operant;
        sub==true? resultat = -num.parse(number[0]) - num.parse(number[1]):
        resultat = num.parse(number[0]) - num.parse(number[1]);
        sub=false;
      }
      else if(operant=='%'){
        if(lastOperant.length==2 && lastOperant.last=='%' && lastOperant.first=='+'){
          resultat= resultat - num.parse(number.last) + num.parse(number.last)/100;
        }
      }
      //division
      else if (operant == '÷') {
        sub==true? resultat = -num.parse(number[0]) / num.parse(number[1]):
        resultat = num.parse(number[0]) / num.parse(number[1]);
        sub=false;
      }
      //multiplication
      else if (operant == 'X') {
        //si l'un des nombres ou les nombres sont decimaux
        if(number.first.contains('.') || number.last.contains('.')) {
          sub==true? resultat = -Decimal.parse(number[0]) * Decimal.parse(number[1]):
          resultat = Decimal.parse(number[0]) * Decimal.parse(number[1]);
          resultat=num.parse(resultat.toString());
        }
        else {
          sub == true ?
          resultat = -num.parse(number[0]) * num.parse(number[1]) :
          resultat = num.parse(number[0]) * num.parse(number[1]);
        }
        sub=false;
      }

    }

    else if (number.length > 2) {
      //addition
      if (operant == '+') {
        //si le nombre de carctère de lastnumber=1
        if (number.last.length == 1) {
          resultat += num.parse(number.last);
        }

        else {
          List<String> precedent_number_split = [];
          List<String> lastNumber_split = number.last.split('').toList();
          for (int i = 0; i < lastNumber_split.length - 1; i++) {
            precedent_number_split.add(lastNumber_split[i]);
          }
          String precedent_number = precedent_number_split.join();
          print("n1:$precedent_number");
          var result = resultat - num.parse(precedent_number);
          resultat = result + num.parse(number.last);
        }
      }
      //soustraction
      else if (operant == '-') {
        //si le nombre de caractère de lastnumber=1
        if(number.last.length==1) {
          resultat -= num.parse(number.last);
        }

        else{
          List<String> number_split=[];
          List<String> lastNumber=number.last.split('').toList();
          for(int i=0;i<lastNumber.length-1;i++){
            number_split.add(lastNumber[i]);
          }
          String n1=number_split.join();
          print("n1:$n1");
          num result=resultat+num.parse(n1);
          resultat=result-num.parse(number.last);
        }
      }
      //division
      else if (operant == '÷') {
        num div = num.parse(number[number.length - 2]) /
            num.parse(number.last);
        //si il y a eu soustraction avant la division
        if ((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='-')
            ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='-')) {
          num result = resultat +
              num.parse(number[number.length - 2]);
          resultat = result - div;
        }
        //si il y a eu addition avant la division
        else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='+')
            ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='+')) {
          num result = resultat -
              num.parse(number[number.length - 2]);
          resultat = result + div;
        }
        //si il y a eu multiplication avant la division
        else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='X')
            ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='X')){
          num result=resultat/num.parse(number[number.length-2]);
          num div=num.parse(number[number.length-2])/num.parse(number.last);
          resultat=result*div;
        }

        else{
          resultat=resultat/num.parse(number.last);
        }

      }
      //multiplication
      else if (operant == 'X') {
        num multiplication = num.parse(number[number.length - 2]) *
            num.parse(number.last);
        //si il y a eu soustraction avant la multiplication
        if ((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='-')
            ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='-')) {
          num result = resultat +
              num.parse(number[number.length - 2]);
          resultat = result - multiplication;
        }
        //si il y a eu addition avant la multiplication
        else if((lastOperant.length>1 && lastOperant[lastOperant.length-2]=='+')
            ||(lastOperant.length==1 && lastOperant[lastOperant.length-1]=='+')) {
          num result = resultat -
              num.parse(number[number.length - 2]);
          resultat = result + multiplication;
        }

        else {
          if(number.last.length==1) {
            resultat = resultat * num.parse(number.last);
          }
          else {
            resultat = resultat/ num.parse(number[number.length - 2]) *
                num.parse(number.last);
          }
        }
      }
    }

  }
}

