import 'dart:html' as html;

void printContentTesting() {
    // Open a new window
    //html.window.open('', '_blank')!.document.write('<h1>Hello World!</h1>');

    // Trigger the browser's print functionality
    html.window.print();
  }