package subproject;

public interface MessageProvider {
    String getMessage();
}

public class Library implements MessageProvider {
    @Override
    public String getMessage() {
        return "Hello from Library!";
    }
}