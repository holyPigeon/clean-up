package com.kyonggi.cleanup.common.domain.response;

import lombok.Builder;
import org.springframework.http.HttpStatus;

@Builder
public record ResponseHandler<T>(HttpStatus statusCode, String message, T data) {
}
