/*
  Arduino Mega 2560 ↔ Altera DE-2
  pin 18 = END (INPUT) : Detect end of RSA operation
  pin 19 = RST (OUTPUT) : Send a reset signal to the FPGA board
  pin 20 = OE (OUTPUT) : Send a oe(output enable) signal to the FPGA board
  pin 21 = WR (OUTPUT) : Send a write signal to the FPGA board
  pin 22 ~ 53 = DATA BUS (INOUT) : Send base, exp, mod to FPGA and Receive result of RSA-operation
*/

#define END 18
#define RST 19
#define OE 20
#define WR 21

static int rsa_end = 0;
static char ch = 0;
static unsigned long start_time = 0;
static unsigned long end_time = 0;
static unsigned long exec_time = 0;

static uint32_t message = 0;
static uint32_t n = 0;
static uint32_t e = 0;
static uint32_t d = 0;
static uint32_t encrypted_message = 0;
static uint32_t decrypted_message = 0;

void setup() {
  Serial.begin(57600);
  
  pinMode(END, INPUT);
  pinMode(RST, OUTPUT);
  pinMode(OE, OUTPUT);
  pinMode(WR, OUTPUT);
  set_pin_out();

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

  // INPUT
  message = 52525252;
  n = 128255609;
  e = 17;
  d = 75431153;

  // RSA-operation
  encrypted_message = encryption(message, n, e);
  decrypted_message = decryption(encrypted_message, n, d);

  // PRINT
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
  digitalWrite(WR, HIGH);
  digitalWrite(WR, LOW);
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
  set_pin_out();
  digitalWrite(OE, LOW);

  // set base (message)
  set_num(message);
  write_to_FPGA();

  // set exponent (e)
  set_num(e);
  write_to_FPGA();

  // set modulus (n)
  set_num(n);
  write_to_FPGA();

  set_pin_in();
  // Start time-measurement
  start_time = micros();
  write_to_FPGA();

  delayMicroseconds(500);
  // Busy-waiting
  while (rsa_end == 0) {
    rsa_end = digitalRead(END);
  }
  // End time-measurement
  end_time = micros();

  // read result (encrypted message)
  digitalWrite(OE, HIGH);
  uint32_t result = pin_to_num();
  digitalWrite(OE, LOW);

  // Calculate execution-time
  exec_time = end_time - start_time;

  // Print Execution Time of Encryption Process
  Serial.print("encryption time : ");
  Serial.print(exec_time - 500);
  Serial.println("us");

  // Reset FPGA
  digitalWrite(RST, LOW);
  delay(100);
  digitalWrite(RST, HIGH);

  return result;
}

uint32_t decryption(uint32_t message, uint32_t n, uint32_t d) {
  set_pin_out();
  // set base (encrypted_message)
  set_num(message);
  write_to_FPGA();

  // set exponent (d)
  set_num(d);
  write_to_FPGA();

  // set modulus (n)
  set_num(n);
  write_to_FPGA();

  set_pin_in();
  // Start time-measurement
  start_time = micros();
  write_to_FPGA();

  delayMicroseconds(500);
  // Busy-waiting
  while (rsa_end == 0) {
    rsa_end = digitalRead(END);
  }
  // End time-mearsurement
  end_time = micros();
  
  // read result (decrypted message)
  digitalWrite(OE, HIGH);
  uint32_t result = pin_to_num();
  digitalWrite(OE, LOW);

  // Calculate execution-time
  exec_time = end_time - start_time;

  // Print Execution Time of Decryption Process
  Serial.print("decryption time : ");
  Serial.print(exec_time - 500);
  Serial.println("us");

  // Reset FPGA
  digitalWrite(RST, LOW);
  delay(100);
  digitalWrite(RST, HIGH);

  return result;
}
// pinMode(22 to 53, INPUT)
void set_pin_in() {
  for (int i = 22; i <= 53; i++) {
    pinMode(i, INPUT);
  }
}
// pinMode(22 to 53, OUTPUT)
void set_pin_out() {
  for (int i = 22; i <= 53; i++) {
    pinMode(i, OUTPUT);
  }
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
