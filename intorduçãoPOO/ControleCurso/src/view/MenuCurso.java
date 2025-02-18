package view;

import java.util.Scanner;

import Controller.Curso;
import Model.Aluno;
import Model.Professor;

public class MenuCurso {

    //atributos

    private boolean continuar = true;
    private int operacao;
    Scanner sc = new Scanner(System.in);

    //metodo

    public void menu (){
        //instancia curso e profesor 
        Professor professor = new Professor("José Pereira","123.456.789-98" , 15000.00);
        Curso curso = new Curso("Programação Java", professor);

        while (continuar) {
            System.out.println("Sistema de Gestao escolar");
            System.out.println("1.Cadastrar Aluno no Curso");
            System.out.println("2.Informacoes do Curso");
            System.out.println("3.Status da Turma");
            System.out.println("4.Sair");
            System.out.println("Escolha a opcao Desejada");

            operacao = sc.nextInt();
            switch (operacao) {
                case 1:
                System.out.println("Informe o Nome Do Aluno");
                String nomeAluno = sc.next();
                System.out.println("Informe o CPF Do Aluno");
                String CPFAluno = sc.next();
                System.out.println("Informe o numero da Matricula");
                String matriculaAluno = sc.next();
                System.out.println("Informe a Nota Do Aluno");
                double notaAluno = sc.nextDouble();
                Aluno aluno = new Aluno(nomeAluno, CPFAluno, matriculaAluno, notaAluno);
                curso.adicionarAluno(aluno);
                    break;

                case 2:
                curso.exibirInformacoesCurso();
                break;

                case 3: //fazer
                break;

                case 4:
                System.out.println("Saindo");
                continuar = false;
                break;
                default:
                    break;
            }
        }

    }

}
