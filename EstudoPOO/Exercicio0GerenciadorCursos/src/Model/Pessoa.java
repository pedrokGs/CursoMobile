package Model;

public class Pessoa { // Encapsulamento
    // Atributos
    private String nome;
    private String cpf;

    // Métodos
    public Pessoa(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }

    public void exibirInformacoes(){
        System.out.println("Nome: " + nome + "| CPF: " + cpf);
    }

    // Getters & Setters

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

}
