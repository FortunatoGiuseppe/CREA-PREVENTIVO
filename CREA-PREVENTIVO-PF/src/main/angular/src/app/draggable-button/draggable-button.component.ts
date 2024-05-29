import { Component } from '@angular/core';

@Component({
  selector: 'app-draggable-button',
  templateUrl: './draggable-button.component.html',
  styleUrl: './draggable-button.component.scss',
})
export class DraggableButtonComponent {

  positionX = 0;
  positionY = 0;
  offsetX = 0;
  offsetY = 0;
  dragging = false;
  buttonText = 'Sposta';

  onMouseDown(event: MouseEvent) {
    this.dragging = true;
    this.offsetX = event.clientX - this.positionX;
    this.offsetY = event.clientY - this.positionY;
  }

  onMouseUp(event: MouseEvent) {
    this.dragging = false;
  }

  onMouseMove(event: MouseEvent) {
    if (this.dragging) {
      this.positionX = event.clientX - this.offsetX;
      this.positionY = event.clientY - this.offsetY;
    }
  }
}
