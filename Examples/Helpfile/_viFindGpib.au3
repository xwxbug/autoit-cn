 ; 该示例执行一个GPIB总线上的搜索并在消息框中显示结果 
 
 #include  <Visa.au3> 
 
 Dim  $a_descriptor_list [ 1 ],  $a_idn_list [ 1 ] 
 _viFindGpib ( $a_descriptor_list ,  $a_idn_list ,  1 ) 
 
