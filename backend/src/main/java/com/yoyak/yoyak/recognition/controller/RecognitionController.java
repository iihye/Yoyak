package com.yoyak.yoyak.recognition.controller;


import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

/**
 * 이미지에서 약을 인식해서 약의 기본 정보를 리턴해주는 컨트롤러
 */
@RestController
@Slf4j
@RequestMapping("/api/recognition")
public class RecognitionController {

    @Value("${fastapi.url}")
    private String fastApiUrl;
    @GetMapping("/test")
    public String test() {
        return "test";
    }
    @PostMapping("/upload")
    public ResponseEntity<Object> uploadImage(@RequestParam("image") MultipartFile file) {
        log.info("file = {}", file.getOriginalFilename());
        try{
            byte[] fileBytes = file.getBytes();
            ByteArrayResource fileResource = new ByteArrayResource(fileBytes){
                @Override
                public String getFilename(){
                    return file.getOriginalFilename();
                }
            };

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);
            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("image", fileResource);

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.postForObject(fastApiUrl, requestEntity, String.class);

            return ResponseEntity.ok().body(response);

        }catch(IOException e){
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

}
