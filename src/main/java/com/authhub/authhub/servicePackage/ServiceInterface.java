package com.authhub.authhub.servicePackage;

import org.springframework.http.ResponseEntity;

import com.authhub.authhub.entities.ClientChallengeDTO;

public interface ServiceInterface {
        public Object PanOutput(ClientChallengeDTO challengeInfo);
        public Object AdharOutput(ClientChallengeDTO challengeInfo);
        public void loggerFunc(ResponseEntity<Object> response);
}
