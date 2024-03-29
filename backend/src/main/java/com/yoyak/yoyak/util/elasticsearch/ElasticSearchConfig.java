package com.yoyak.yoyak.util.elasticsearch;

import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ElasticSearchConfig {

    @Value("${elasticsearch.url}")
    private String serverUrl;

    @Bean
    public RestClient restClient() {
        return RestClient.builder(HttpHost.create(serverUrl)).build();
    }
}
