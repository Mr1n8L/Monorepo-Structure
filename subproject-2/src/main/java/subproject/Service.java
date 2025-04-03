package subproject;

import subproject.MessageProvider;

public class Service {
    private final MessageProvider messageProvider;

    public Service(MessageProvider messageProvider) {
        this.messageProvider = messageProvider;
    }

    public String serve() {
        return messageProvider.getMessage();
    }
}