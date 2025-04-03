package subproject;

import subproject.Library;
import subproject.Service;
import subproject.MessageProvider;

public class ServiceFactory {
    public static Service createService() {
        MessageProvider provider = new Library();
        return new Service(provider);
    }
}

public class App {
    public String getGreeting() {
        Service service = ServiceFactory.createService();
        return service.serve();
    }

    public static void main(String[] args) {
        System.out.println(new App().getGreeting());
    }
}