import javax.swing.JOptionPane;

public static class Input {
  
  static String prompt(String s) {
     println(s);
     String entry = JOptionPane.showInputDialog(s);
     if (entry == null) { // to prevent user from cancelling out of input box
        return prompt(s);
     }
     //println(entry);
     return entry;
  }
  
  static String getString(String s) {
     return prompt(s);
  }

}
