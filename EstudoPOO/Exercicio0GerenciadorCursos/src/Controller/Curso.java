package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;


public class Curso {
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunos = new ArrayList<>();

    public Curso(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
    }

    public void adicionarAluno(Aluno aluno){
        alunos.add(aluno);
    }

    public void exibirInformacoesCurso(){
        System.out.println("Nome do curso: " + nomeCurso + "| Professor: " + professor.getNome());
        int i = 1;
        if (alunos.size() >= 1) {
            for ( Aluno aluno : alunos) {
                System.out.println(i + ". " + aluno.getNome());
                i++;
            }
        }
    }

    public void exibirStatusAluno(){
        int i = 1;
        for (Aluno aluno : alunos) {
            if (aluno.getNota() >= 6)
                System.out.println(i + ". " + aluno.getNome() + "| Aprovado");
            else 
                System.out.println(i + ". " + aluno.getNome() + "| Reprovado");
            i++;
        }
    }

    
}
