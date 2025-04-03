package subproject;

import subproject.MessageProvider;
import lib.Utility;

public class Service {
    private final MessageProvider messageProvider;

    public Service(MessageProvider messageProvider) {
        this.messageProvider = messageProvider;
    }

    public String serve() {
        return Utility.formatMessage(messageProvider.getMessage());
    }
}