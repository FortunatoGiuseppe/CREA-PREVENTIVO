import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DraggableButtonComponent } from './draggable-button.component';
import {MatIconModule} from '@angular/material/icon';
import {MatDividerModule} from '@angular/material/divider';
import {MatButtonModule} from '@angular/material/button';

@NgModule({
  declarations: [
    DraggableButtonComponent
  ],
  imports: [
    CommonModule, MatButtonModule, MatDividerModule, MatIconModule
  ],
  exports: [
    DraggableButtonComponent
  ]
})
export class DraggableButtonModule { }