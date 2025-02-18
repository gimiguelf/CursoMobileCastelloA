package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class Curso {
    //atributos
    private String nomeCurso;
    private Professor professor;
    private List<Aluno>alunos;

public Curso(String nomeCurso,Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        alunos = new ArrayList<>();
    }

    // construtor
    //adicionarAlunos

public void adicionarAluno(Aluno aluno){
        alunos.add(aluno);
    }
    //exibirInformacoesCurso

public void exibirInformacoesCurso(){
        System.out.println("Nome do Curso: "+nomeCurso);
        System.out.println("Nome do professor: "+professor.getNome());

    //foreach

        int contador = 0;

        System.out.println("==================================");
        for (Aluno aluno : alunos) { contador++;
            System.out.println(contador+". "+aluno.getNome());
            System.out.println("==================================");
            
        }

    }




}

