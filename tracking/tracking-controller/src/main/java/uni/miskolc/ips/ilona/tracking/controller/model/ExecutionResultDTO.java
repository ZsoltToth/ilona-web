package uni.miskolc.ips.ilona.tracking.controller.model;

import java.util.Collection;

public class ExecutionResultDTO {

	private boolean executionState;

	private Collection<String> messages;

	public ExecutionResultDTO() {

	}

	public ExecutionResultDTO(boolean executionState, Collection<String> messages) {
		super();
		this.executionState = executionState;
		this.messages = messages;
	}

	public void addMessage(String message) {
		if (message == null) {
			return;
		}
		if(messages != null) {
			messages.add(message);
		}
	}
	
	public boolean isExecutionState() {
		return executionState;
	}

	public void setExecutionState(boolean executionState) {
		this.executionState = executionState;
	}

	public Collection<String> getMessages() {
		return messages;
	}

	public void setMessages(Collection<String> messages) {
		this.messages = messages;
	}

}
