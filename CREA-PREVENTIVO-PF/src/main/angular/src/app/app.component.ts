import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { PDFDati } from './pdfdati.model';
import { ApiService } from './api.service';
import { DraggableButtonModule } from './draggable-button/draggable-button.module';
import { MaterialButtonModule } from './material-button/material-button.module';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
  imports: [FormsModule, DraggableButtonModule, MaterialButtonModule],
  standalone: true
})
export class AppComponent {
  inputData: PDFDati = new PDFDati();
  generatedPDF: Blob | null = null;

  constructor(private apiService: ApiService) {}

  generatePDF(): void {
    this.apiService.generatePDF(this.inputData)
      .subscribe(
        response => {
          console.log('PDF generato:', response);
          this.generatedPDF = response;
        },
        error => {
          console.error('Errore durante la generazione del PDF:', error);
        }
      );
  }

  downloadPDF(): void {
    if (this.generatedPDF) {
      const url = window.URL.createObjectURL(this.generatedPDF);
      const link = document.createElement('a');
      link.href = url;
      link.download = 'output.pdf';
      link.click();
    }
  }
}