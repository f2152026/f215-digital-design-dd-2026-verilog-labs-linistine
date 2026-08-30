module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3, c4;

  wire p0cin;
  wire p1g0, p1p0cin;
  wire p2g1, p2p1g0, p2p1p0cin;
  wire p3g2, p3p2g1, p3p2p1g0, p3p2p1p0cin;

  // Propagate
  xor #(2) (p0, a[0], b[0]);
  xor #(2) (p1, a[1], b[1]);
  xor #(2) (p2, a[2], b[2]);
  xor #(2) (p3, a[3], b[3]);

  // Generate
  and #(2) (g0, a[0], b[0]);
  and #(2) (g1, a[1], b[1]);
  and #(2) (g2, a[2], b[2]);
  and #(2) (g3, a[3], b[3]);

  // c1
  and #(2) (p0cin, p0, cin);
  or  #(2) (c1, g0, p0cin);

  // c2
  and #(2) (p1g0, p1, g0);
  and #(2) (p1p0cin, p1, p0, cin);
  or  #(2) (c2, g1, p1g0, p1p0cin);

  // c3
  and #(2) (p2g1, p2, g1);
  and #(2) (p2p1g0, p2, p1, g0);
  and #(2) (p2p1p0cin, p2, p1, p0, cin);
  or  #(2) (c3, g2, p2g1, p2p1g0, p2p1p0cin);

  // c4
  and #(2) (p3g2, p3, g2);
  and #(2) (p3p2g1, p3, p2, g1);
  and #(2) (p3p2p1g0, p3, p2, p1, g0);
  and #(2) (p3p2p1p0cin, p3, p2, p1, p0, cin);

  or #(2) (c4, g3, p3g2, p3p2g1,
                 p3p2p1g0, p3p2p1p0cin);

  // Sum
  xor #(2) (sum[0], p0, cin);
  xor #(2) (sum[1], p1, c1);
  xor #(2) (sum[2], p2, c2);
  xor #(2) (sum[3], p3, c3);

  // Carry out
  assign #(2) cout = c4;

endmodule
  // TODO: your gate-level P/G, carry, and sum logic goes here.
  // (cout should be connected to c4.) Remember the delay on every gate.

endmodule
