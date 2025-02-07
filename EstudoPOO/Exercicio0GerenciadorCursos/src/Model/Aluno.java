package Model;

public class Aluno extends Pessoa implements Avaliavel{
    //  Atributos
    private String matricula;
    private double nota;

    //  Métodos
    public Aluno(String nome, String cpf, String matricula, double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }

    @Override
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Matrícula: " + matricula + "| Nota: " + nota);
    }

    //  Getters & Setters

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public double getNota() {
        return nota;
    }

    public void setNota(double nota) {
        this.nota = nota;
    }

    @Override
    public void avaliarDesempenho() {
        if (nota >= 6)
            System.out.println("Aluno aprovado!");
        else
            System.out.println("Aluno reprovado!");
        
    }
}
