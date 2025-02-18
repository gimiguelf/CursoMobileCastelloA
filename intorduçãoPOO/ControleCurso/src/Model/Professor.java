package Model;

public class Professor extends Pessoa {

    //atributos 

    private double salario;

    //metodos
    //construtor

    public Professor(String nome, String CPF, double salario) {
        super(nome, CPF);
        this.salario = salario;
    }

    //getters and setters

    public double getSalario() {
        return salario;
    }
    public void setSalario(double salario) {
        this.salario = salario;
    }

    @Override //polimorfismo
    public void exibirInformacoes() {
        // TODO Auto-generated method stub
        super.exibirInformacoes();
    }
}

