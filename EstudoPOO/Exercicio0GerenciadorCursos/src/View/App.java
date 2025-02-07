package View;

import java.util.Scanner;

import Controller.Curso;
import Model.Aluno;
import Model.Professor;

public class App {
    public static void main(String[] args) throws Exception {
        Professor prof1 = new Professor("José Pereira", "123.456.789-00", 15000.00);
        Curso curso1 = new Curso("Programação java", prof1);

        int operacao;
        boolean continuar = true;

        while (continuar) {
            System.out.println("=x=x=x=x=x=x=x=x=x=x=x=x=x=");
            System.out.println("Escolha a opção desejada");
            System.out.println("1. Adicionar aluno");
            System.out.println("2. Informações do curso");
            System.out.println("3. Exibir status dos alunos");
            System.out.println("4. Sair");
            System.out.println("=x=x=x=x=x=x=x=x=x=x=x=x=x=");
            Scanner sc = new Scanner(System.in);

            operacao = sc.nextInt();

            switch (operacao) {
                case 1:
                    System.out.println("Insira o nome do aluno: ");
                    String nomeAluno = sc.next();

                    System.out.println("Digite o cpf do aluno: ");
                    String cpfAluno = sc.next();

                    System.out.println("Digite a matrícula do aluno: ");
                    String matriculaAluno = sc.next();

                    System.out.println("Digite a nota do aluno: ");
                    double notaAluno = sc.nextDouble();

                    Aluno aluno = new Aluno(nomeAluno, cpfAluno, matriculaAluno, notaAluno);
                    curso1.adicionarAluno(aluno);

                    System.out.println("Aluno adicionado com sucesso!");
                    break;

                case 2:
                    curso1.exibirInformacoesCurso();
                    break;

                case 3:
                    curso1.exibirStatusAluno();
                    break;

                case 4:

                    System.out.println("Encerrando o sistema");
                    continuar = false;
                    break;

                default:
                    System.out.println("Opção inválida!");
                    break;
            }
        }
    }
}
