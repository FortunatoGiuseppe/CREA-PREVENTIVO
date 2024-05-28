import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { PDFDati } from './pdfdati.model';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  private baseUrl = 'http://localhost:8080'; // URL del tuo backend Spring Boot

  constructor(private http: HttpClient) { }

  generatePDF(inputData: PDFDati): Observable<Blob> {
    return this.http.post(`${this.baseUrl}/generate-pdf`, inputData, {
      responseType: 'blob' // Imposta il tipo di risposta su blob
    }).pipe(
      catchError(this.handleError) // Gestisci eventuali errori
    );
  }

  private handleError(error: HttpErrorResponse) {
    if (error.error instanceof ErrorEvent) {
      // Errore lato client
      console.error('Errore:', error.error.message);
    } else {
      // Errore lato server
      console.error(
        `Codice di errore: ${error.status}, ` +
        `messaggio: ${error.error}`);
    }
    // Ritorna un observable con un messaggio di errore utile per l'utente
    return throwError('Qualcosa è andato storto; si prega di riprovare più tardi.');
  }
}
