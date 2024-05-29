import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {MatIconModule} from '@angular/material/icon';
import {MatDividerModule} from '@angular/material/divider';
import {MatButtonModule} from '@angular/material/button';
import {MaterialButtonComponent } from './material-button.component';

@NgModule({
  declarations: [
    MaterialButtonComponent
  ],
  imports: [
    CommonModule, MatButtonModule, MatDividerModule, MatIconModule
  ],
  exports: [
    MaterialButtonComponent
  ]
})
export class MaterialButtonModule { }