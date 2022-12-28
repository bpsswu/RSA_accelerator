# RSA accelerator

## About this project
### Description
- The RSA encryption module is implemented on the FPGA board using Verilog
- Connect the FPGA board and the Arduino board to use the FPGA board as an accelerator
### Algorithm used
- RL binary method
- Montgomery Modular Multiplication
- Long division
### Accelerator Verilog Structure
![image](https://user-images.githubusercontent.com/101001675/209766791-ce49cfd6-bf10-4492-b6fa-c9578989049e.png)
### Connection structure between Arduino and accelerator
![image](https://user-images.githubusercontent.com/101001675/209767462-4be4ac3f-62f9-4add-a246-006269322da3.png)
### Data transmission method between Arduino and accelerator
![image](https://user-images.githubusercontent.com/101001675/209767532-7ddb298d-038f-4a29-a605-afe25793fca6.png)

## Directory Structure
- /source_c
    - Implementing RSA in C language
    - Implemented up to 32bit and 2048bit
- /source_v
    - Implementing RSA in verilog
    - Implemented up to 32bit
- /source_arduino
    - Running rsa-32 on Arduino itself
    - Running rsa-32 with an accelerator

## cf.

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/sirkang1208"><img src="https://avatars.githubusercontent.com/u/104350527?v=4" width="100px;" alt=""/><br /><sub><b>sirkang1208</b></sub></a></td>
    <td align="center"><a href="https://github.com/bpsswu"><img src="https://avatars.githubusercontent.com/u/101001675?v=4" width="100px;" alt=""/><br /><sub><b>bpsswu</b></sub></a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
