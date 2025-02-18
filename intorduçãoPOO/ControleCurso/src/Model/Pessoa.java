package Model;

public abstract class Pessoa {
    //atributos (encapsulamento)
    private String nome;
    private String CPF;
    //métodos
    //construtor
    public Pessoa (String nome, String CPF){
        this.nome = nome;
        this.CPF = CPF;
    }
    //geterrs in setters
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCPF() {
        return CPF;
    }
    public void setCPF(String CPF) {
        this.CPF = CPF;
    }

    //Exibir Informacoes
    public void exibirInformacoes(){
        System.out.println("Nome: "+nome);
        System.out.println("Nome: "+CPF);

    } 
}
