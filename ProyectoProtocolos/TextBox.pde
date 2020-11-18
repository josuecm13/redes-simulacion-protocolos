public class TextBox {
   public int X = 0, Y = 0, H = 35, W = 200;
   public int TEXTSIZE = 12;
   
   // COLORS
   public color background = color(140, 140, 140);
   public color foreground = color(0, 0, 0);
   public color backgroundSelected = color(160, 160, 160);
   public color border = color(30, 30, 30);
   
   public boolean borderEnable = false;
   public int borderWeight = 1;
   
   public String Text = "";
   public String title = "";
   public int TextLength = 0;

   private boolean selected = false;
   
   TextBox() {
      
   }
   
   TextBox(float x, float y, float w, float h) {
      X = (int) x; Y = (int) y; W = (int) w; H = (int) h;
   }
   
   TextBox(float x, float y, float w, float h, String title) {
      X = (int) x; Y = (int) y; W = (int) w; H = (int) h;
      this.title = title;
   }
   
   void DRAW() {
      // DRAWING THE BACKGROUND
      if (selected) {
         fill(backgroundSelected);
      } else {
         fill(background);
      }
      
      if (borderEnable) {
         strokeWeight(borderWeight);
         stroke(border);
      } else {
         noStroke();
      }
      
      rect(X, Y, W, H);
      
      // DRAWING THE TEXT ITSELF
      fill(foreground);
      textSize(TEXTSIZE);
      text(Text, X + (textWidth("a") / 2), Y + TEXTSIZE);
      text(title, X, Y + TEXTSIZE - 24);
   }
   
   // IF THE KEYCODE IS ENTER RETURN 1
   // ELSE RETURN 0
   boolean KEYPRESSED(char KEY, int KEYCODE) {
      if (selected) {
         if (KEYCODE == (int)BACKSPACE) {
            BACKSPACE();
         } else if (KEYCODE == 32) {
            // SPACE
            addText(' ');
         } else if (KEYCODE == (int)ENTER) {
            return true;
         } else {
            // CHECK IF THE KEY IS A LETTER OR A NUMBER
            boolean isKeyCapitalLetter = (KEY >= 'A' && KEY <= 'Z');
            boolean isKeySmallLetter = (KEY >= 'a' && KEY <= 'z');
            boolean isKeyNumber = (KEY >= '0' && KEY <= '9');
      
            if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber) {
               addText(KEY);
            }
         }
      }
      
      return false;
   }
   
   private void addText(char text) {
      // IF THE TEXT WIDHT IS IN BOUNDARIES OF THE TEXTBOX
      if (textWidth(Text + text) < W) {
         Text += text;
         TextLength++;
      }
   }
   
   private void BACKSPACE() {
      if (TextLength - 1 >= 0) {
         Text = Text.substring(0, TextLength - 1);
         TextLength--;
      }
   }
   
   // FUNCTION FOR TESTING IS THE POINT
   // OVER THE TEXTBOX
   private boolean overBox(int x, int y) {
      if (x >= X && x <= X + W) {
         if (y >= Y && y <= Y + H) {
            return true;
         }
      }
      
      return false;
   }
   
   Boolean PRESSED(int x, int y) {
      if (overBox(x, y)) {
         selected = true;
         if(Text == "\tEmpezar simulación"){
           return true;
         }
      } else {
         selected = false;
      }
      return false;
   }
}
