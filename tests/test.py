import pathlib, subprocess, tempfile
with tempfile.TemporaryDirectory() as d:
    p=pathlib.Path(d)/'sample.bin'
    for data in (b'', b'Hello\x00\xff', bytes(range(256)), b'x'*17):
        p.write_bytes(data)
        result=subprocess.check_output(['./analizador',str(p)]).decode()
        lines=result.splitlines()
        assert lines[-1]==f'Bytes totales (hex): {len(data):016X}'
        for i,row in enumerate(lines[:-1]):
            offset=i*16
            assert row.startswith(f'{offset:016X} ')
            assert bytes.fromhex(row[17:65])==data[offset:offset+16]
            assert row[65:]== '|'+''.join(chr(b) if 32<=b<=126 else '.' for b in data[offset:offset+16])+'|'
    assert subprocess.run(['./analizador',str(p)+'missing'],capture_output=True).returncode==1
    assert subprocess.run(['./analizador'],capture_output=True).returncode==2
print('6 casos correctos')
