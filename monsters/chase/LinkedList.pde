
class LinkedList {
  // simple linked list for the line
  Line2d line2d;
  LinkedList next;
  int eaten;

  LinkedList(Line2d line2d, int maxEat, LinkedList next) {
    this.line2d = line2d;
    this.eaten = maxEat;
    this.next = next;
  }
}

