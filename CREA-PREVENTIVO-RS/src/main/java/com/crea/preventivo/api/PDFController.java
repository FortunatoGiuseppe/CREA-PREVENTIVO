package com.crea.preventivo.api;

import com.crea.preventivo.manager.PDFGenerator;
import com.crea.preventivo.model.PDFDati;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PDFController {

    @PostMapping("/generate-pdf")
    public ResponseEntity<byte[]> generatePDF(@RequestBody PDFDati input) {

        // Implementa la logica per generare il PDF utilizzando i dati ricevuti dall'interfaccia utente
        byte[] pdfContent = PDFGenerator.generatePDF(input);

        // Restituisci il PDF come array di byte
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("filename", "output.pdf");
        headers.setContentLength(pdfContent.length);
        return new ResponseEntity<>(pdfContent, headers, HttpStatus.OK);
    }

}
