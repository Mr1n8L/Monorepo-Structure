package subproject;

public class App {
    public String getGreeting() {
        Service service = new Service();
        return service.serve();
    }

    public static void main(String[] args) {
        System.out.println(new App().getGreeting());
    }
}