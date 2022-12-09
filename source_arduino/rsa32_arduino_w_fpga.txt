#define END 18
#define RST 19
#define OE 20
#define WRITE 21

int rsa_end = 0;

char ch = 0;

unsigned long start_time = 0;
unsigned long end_time = 0;
unsigned long exec_time = 0;

uint32_t message = 0;
uint32_t n = 0;
uint32_t e = 0;
uint32_t d = 0;
uint32_t encrypted_message = 0;
uint32_t decrypted_message = 0;

void setup() {
  pinMode(END, INPUT);
  pinMode(RST, OUTPUT);
  pinMode(OE, OUTPUT);
  pinMode(WRITE, OUTPUT);
  set_pin_out();

  Serial.begin(9600);

  digitalWrite(RST, HIGH);

  Serial.println("... To start, enter 's' ... ");
  while (ch != 's') {
    ch = Serial.read();
    if (ch == 'r') {
      Serial.println("-- reset --");
      digitalWrite(RST, LOW);
      delay(300);
      digitalWrite(RST, HIGH);
    }
  }

  digitalWrite(RST, LOW);
  delay(300);
  digitalWrite(RST, HIGH);

  message = 52525252;
  n = 128255609;
  e = 17;
  d = 75431153;

  encrypted_message = encryption(message, n, e);
  decrypted_message = decryption(encrypted_message, n, d);

  Serial.println();
  Serial.print("message = ");
  Serial.println(message);
  Serial.print("encrypted message = ");
  Serial.println(encrypted_message);
  Serial.print("decrypted message = ");
  Serial.println(decrypted_message);
}

void loop() {
  ch = Serial.read();
  if (ch == 'r') {
    Serial.println("-- RESET");
    digitalWrite(RST, LOW);
    digitalWrite(RST, HIGH);
  }
}

void write_to_FPGA() {
  digitalWrite(WRITE, HIGH);
  digitalWrite(WRITE, LOW);
}

// read pin(22-53) value and convert it to decimal number
uint32_t pin_to_num() {
  uint32_t result = 0;
  char arr[32] = {
    0,
  };
  for (int i = 0; i < 32; i++) {
    arr[i] = digitalRead(22 + i);
    if (arr[i]) {
      result += power(2, i);
    }
  }
  return result;
}

uint32_t power(int base, int exp) {
  uint32_t result = 1;
  for (int i = 0; i < exp; i++) {
    result *= base;
  }
  return result;
}

uint32_t encryption(uint32_t message, uint32_t n, uint32_t e) {

  //Serial.print("encryption start ... ");

  set_pin_out();
  digitalWrite(OE, LOW);

  // set base (message)
  // set_h0321_78C4();
  set_num(message);
  write_to_FPGA();

  // set exponent (e)
  // set_h0000_0011();
  set_num(e);
  write_to_FPGA();

  // set modulus (n)
  // set_h07A5_0679();
  set_num(n);
  write_to_FPGA();

  start_time = micros();

  write_to_FPGA();
  set_pin_in();

  delayMicroseconds(500);
  // Busy-waiting
  while (rsa_end == 0) {
    rsa_end = digitalRead(END);
  }
  end_time = micros();
  digitalWrite(OE, HIGH);
  // read result (encrypted message)
  uint32_t result = pin_to_num();

  digitalWrite(OE, LOW);

  exec_time = end_time - start_time;

  //Serial.println(" ... encryption end");
  Serial.print("encryption time : ");
  Serial.print(exec_time - 500);
  Serial.println("us");

  digitalWrite(RST, LOW);
  delay(100);
  digitalWrite(RST, HIGH);

  return result;
}

uint32_t decryption(uint32_t message, uint32_t n, uint32_t d) {

  //Serial.print("decryption start ... ");

  set_pin_out();
  digitalWrite(OE, LOW);

  // set base (encrypted_message)
  // set_h007D_C743();
  set_num(message);
  write_to_FPGA();

  // set exponent (d)
  // set_h047E_FCF1();
  set_num(d);
  write_to_FPGA();

  // set modulus (n)
  // set_h07A5_0679();
  set_num(n);
  write_to_FPGA();

  start_time = micros();

  write_to_FPGA();
  set_pin_in();

  delayMicroseconds(500);

  // Busy-waiting
  while (rsa_end == 0) {
    rsa_end = digitalRead(END);
  }
  end_time = micros();
  digitalWrite(OE, HIGH);
  // read result (decrypted message)
  uint32_t result = pin_to_num();

  digitalWrite(OE, LOW);

  exec_time = end_time - start_time;

  //Serial.println(" ... decryption end");
  Serial.print("decryption time : ");
  Serial.print(exec_time - 500);
  Serial.println("us");

  digitalWrite(RST, LOW);
  delay(100);
  digitalWrite(RST, HIGH);

  return result;
}
// pinMode(22-53, INPUT)
void set_pin_in() {
  pinMode(22, INPUT);
  pinMode(23, INPUT);
  pinMode(24, INPUT);
  pinMode(25, INPUT);
  pinMode(26, INPUT);
  pinMode(27, INPUT);
  pinMode(28, INPUT);
  pinMode(29, INPUT);
  pinMode(30, INPUT);
  pinMode(31, INPUT);
  pinMode(32, INPUT);
  pinMode(33, INPUT);
  pinMode(34, INPUT);
  pinMode(35, INPUT);
  pinMode(36, INPUT);
  pinMode(37, INPUT);
  pinMode(38, INPUT);
  pinMode(39, INPUT);
  pinMode(40, INPUT);
  pinMode(41, INPUT);
  pinMode(42, INPUT);
  pinMode(42, INPUT);
  pinMode(43, INPUT);
  pinMode(44, INPUT);
  pinMode(45, INPUT);
  pinMode(46, INPUT);
  pinMode(47, INPUT);
  pinMode(48, INPUT);
  pinMode(49, INPUT);
  pinMode(50, INPUT);
  pinMode(51, INPUT);
  pinMode(52, INPUT);
  pinMode(53, INPUT);
}
// pinMode(22-53, OUTPUT)
void set_pin_out() {
  pinMode(22, OUTPUT);
  pinMode(23, OUTPUT);
  pinMode(24, OUTPUT);
  pinMode(25, OUTPUT);
  pinMode(26, OUTPUT);
  pinMode(27, OUTPUT);
  pinMode(28, OUTPUT);
  pinMode(29, OUTPUT);
  pinMode(30, OUTPUT);
  pinMode(31, OUTPUT);
  pinMode(32, OUTPUT);
  pinMode(33, OUTPUT);
  pinMode(34, OUTPUT);
  pinMode(35, OUTPUT);
  pinMode(36, OUTPUT);
  pinMode(37, OUTPUT);
  pinMode(38, OUTPUT);
  pinMode(39, OUTPUT);
  pinMode(40, OUTPUT);
  pinMode(41, OUTPUT);
  pinMode(42, OUTPUT);
  pinMode(42, OUTPUT);
  pinMode(43, OUTPUT);
  pinMode(44, OUTPUT);
  pinMode(45, OUTPUT);
  pinMode(46, OUTPUT);
  pinMode(47, OUTPUT);
  pinMode(48, OUTPUT);
  pinMode(49, OUTPUT);
  pinMode(50, OUTPUT);
  pinMode(51, OUTPUT);
  pinMode(52, OUTPUT);
  pinMode(53, OUTPUT);
}

void set_num(uint32_t num) {
  uint32_t q = num;
  int r = 0;

  char arr[32] = {
    0,
  };

  int i = 0;
  while (q != 0) {
    r = q % 2;
    q = q / 2;
    arr[i] = r;
    i++;
  }

  for (int j = 0; j < 32; j++) {
    // if (arr[j] == 0) {
    //   digitalWrite(22 + j, LOW);
    // }
    // else {
    //   digitalWrite(22 + j, HIGH);
    // }
    digitalWrite(22 + j, arr[j]);
  }
}
