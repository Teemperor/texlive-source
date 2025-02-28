@x
@d my_name=='pbibtex'
@d banner=='This is pBibTeX, Version 0.99d-j0.35'
@y
@d my_name=='upbibtex'
@d banner=='This is upBibTeX, Version 0.99d-j0.35-u1.29'
@z

@x
for i:=@'200 to @'237 do xchr[i]:=chr(i-@'200);
for i:=@'240 to 255 do xchr[i]:=chr(i);
@y
for i:=@'200 to 255 do xchr[i]:=chr(i);
@z

@x
for i:=@'200 to @'237 do xord[i]:= i-@'200;
for i:=@'240 to 255 do xord[i]:=i;
@y
for i:=@'200 to 255 do xord[i]:=i;
@z

@x
@d zen_pun_first = 161          {Zenkaku punctuation first byte; in EUC}
@d zen_space = 161              {Zenkaku space first, second byte; in EUC}
@d zen_kuten = 162              {Zenkaku kuten second byte; in EUC}
@d zen_ten = 163                {Zenkaku ten second byte; in EUC}
@d zen_comma = 164              {Zenkaku comman second byte; in EUC}
@d zen_period = 165             {Zenkaku period second byte; in EUC}
@d zen_question = 169           {Zenkaku question mark second byte; in EUC}
@d zen_exclamation = 170        {Zenkaku exclamation mark second byte; in EUC}
@y
@d e_ss3 = @"8F                 {single shift three in EUC}
@d e_pun_first = @"A1           {Zenkaku punctuation first byte; in EUC}
@d e_space = @"A1A1             {Zenkaku space; in EUC}
@d e_toten = @"A1A2             {Zenkaku kuten; in EUC}
@d e_kuten = @"A1A3             {Zenkaku toten; in EUC}
@d e_comma = @"A1A4             {Zenkaku comman; in EUC}
@d e_period = @"A1A5            {Zenkaku period; in EUC}
@d e_question = @"A1A9          {Zenkaku question mark; in EUC}
@d e_exclamation =@"A1AA        {Zenkaku exclamation mark; in EUC}
@d u_pun_first1 = @"E3          {Zenkaku punctuation first byte(1); in UTF-8}
@d u_pun_first2 = @"EF          {Zenkaku punctuation first byte(2); in UTF-8}
@d u_space = @"3000             {Zenkaku space; in UCS}
@d u_toten = @"3001             {Zenkaku toten; in UCS}
@d u_kuten = @"3002             {Zenkaku kuten; in UCS}
@d u_comma = @"FF0C             {Zenkaku comman; in UCS}
@d u_period = @"FF0E            {Zenkaku period; in UCS}
@d u_question = @"FF1F          {Zenkaku question mark; in UCS}
@d u_exclamation = @"FF01       {Zenkaku exclamation mark; in UCS}
@d u_double_question = @"2047   {Zenkaku double question mark; in UCS}
@d u_double_exclam   = @"203C   {Zenkaku double exclamation mark; in UCS}
@d u_interrobang     = @"203D   {Zenkaku interrobang; in UCS}
@d u_question_exclam = @"2048   {Zenkaku question exclamation mark; in UCS}
@d u_exclam_question = @"2049   {Zenkaku exclamation question mark; in UCS}
@z

@x
for i:=@'200 to @'237 do lex_class[i] := illegal;
for i:=@'240 to 255 do lex_class[i] := alpha;
lex_class[@'33]:=alpha;
@y
@z

@x
for i:=@'200 to @'237 do id_class[i] := illegal_id_char;
@y
@z

@x
for i:=@'240 to 254 do char_width[i]:=514;
@y
@z

@x procedure lower_case
procedure lower_case (var buf:buf_type; @!bf_ptr,@!len:buf_pointer);
var i:buf_pointer;
begin
if (len > 0) then
  for i := bf_ptr to bf_ptr+len-1 do
    if ((buf[i]>="A") and (buf[i]<="Z")) then
        buf[i] := buf[i] + case_difference;
@y
procedure lower_case (var buf:buf_type; @!bf_ptr,@!len:buf_pointer);
var i:buf_pointer;
    @!ch:integer;
begin
if (len > 0) then
  for i := bf_ptr to bf_ptr+len-1 do
    if ((buf[i]>="A") and (buf[i]<="Z")) then begin
        buf[i] := buf[i] + case_difference;
    end
    else if ((is_internalUPTEX) and (buf[i]>=@"C3) and (buf[i]<=@"D4)) then begin
        ch := fromBUFF(buf,i+2,i);
        if (((ch>=@"C0) and (ch<=@"DE) and (ch<>@"D7)) or
            ((ch>=@"391) and (ch<=@"3AA) and (ch<>@"3A2)) or
            ((ch>=@"410) and (ch<=@"42F))) then begin
            ch := toBUFF(ch + case_difference);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if (((ch>=@"100) and (ch<=@"137) and ((ch mod 2)=0)) or
                 ((ch>=@"139) and (ch<=@"148) and ((ch mod 2)=1)) or
                 ((ch>=@"14A) and (ch<=@"177) and ((ch mod 2)=0)) or
                 ((ch>=@"179) and (ch<=@"17E) and ((ch mod 2)=1)) or
                 ((ch>=@"370) and (ch<=@"373) and ((ch mod 2)=0)) or
                 ( ch=@"376 ) or
                 ((ch>=@"3D8) and (ch<=@"3EF) and ((ch mod 2)=0)) or
                 ( ch=@"3F7 ) or  ( ch=@"3FA ) or
                 ((ch>=@"460) and (ch<=@"481) and ((ch mod 2)=0)) or
                 ((ch>=@"48A) and (ch<=@"4BF) and ((ch mod 2)=0)) or
                 ((ch>=@"4C1) and (ch<=@"4CE) and ((ch mod 2)=1)) or
                 ((ch>=@"4D0) and (ch<=@"52F) and ((ch mod 2)=0))) then begin
            ch := toBUFF(ch + 1);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if (ch=@"178) then begin
            ch := toBUFF(@"FF);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if ((ch>=@"400) and (ch<=@"40F)) then begin
            ch := toBUFF(ch + @"50);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if (ch=@"4C0) then begin
            ch := toBUFF(@"4CF);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
    end
@z

@x procedure upper_case
var i:buf_pointer;
begin
if (len > 0) then
  for i := bf_ptr to bf_ptr+len-1 do
    if ((buf[i]>="a") and (buf[i]<="z")) then
        buf[i] := buf[i] - case_difference;
@y
var i:buf_pointer;
    @!ch:integer;
begin
if (len > 0) then
  for i := bf_ptr to bf_ptr+len-1 do
    if ((buf[i]>="a") and (buf[i]<="z")) then begin
        buf[i] := buf[i] - case_difference;
    end
    else if ((is_internalUPTEX) and (buf[i]>=@"C3) and (buf[i]<=@"D4)) then begin
        ch := fromBUFF(buf,i+2,i);
        if (((ch>=@"E0) and (ch<=@"FE) and (ch<>@"F7)) or
            ((ch>=@"3B1) and (ch<=@"3CA) and (ch<>@"3C2)) or
            ((ch>=@"430) and (ch<=@"44F))) then begin
            ch := toBUFF(ch - case_difference);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if (((ch>=@"100) and (ch<=@"137) and ((ch mod 2)=1)) or
                 ((ch>=@"139) and (ch<=@"148) and ((ch mod 2)=0)) or
                 ((ch>=@"14A) and (ch<=@"177) and ((ch mod 2)=1)) or
                 ((ch>=@"179) and (ch<=@"17E) and ((ch mod 2)=0)) or
                 ((ch>=@"370) and (ch<=@"373) and ((ch mod 2)=1)) or
                 ( ch=@"377 ) or
                 ((ch>=@"3D8) and (ch<=@"3EF) and ((ch mod 2)=1)) or
                 ( ch=@"3F8 ) or  ( ch=@"3FB ) or
                 ((ch>=@"460) and (ch<=@"481) and ((ch mod 2)=1)) or
                 ((ch>=@"48A) and (ch<=@"4BF) and ((ch mod 2)=1)) or
                 ((ch>=@"4C1) and (ch<=@"4CE) and ((ch mod 2)=0)) or
                 ((ch>=@"4D0) and (ch<=@"52F) and ((ch mod 2)=1))) then begin
            ch := toBUFF(ch - 1);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if (ch=@"DF) then begin { Latin Small Letter Sharp S }
            buf[i]   := "S";
            buf[i+1] := "S";
        end
        else if (ch=@"FF) then begin
            ch := toBUFF(@"178);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if ((ch>=@"450) and (ch<=@"45F)) then begin
            ch := toBUFF(ch - @"50);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
        else if (ch=@"4CF) then begin
            ch := toBUFF(@"4C0);
            buf[i]   := BYTE3(ch);
            buf[i+1] := BYTE4(ch);
        end
    end
@z

@x procedure get_the_top_level_aux_file_name
label aux_found,@!aux_not_found;
@y
label aux_found,@!aux_not_found;
var i:0..last_text_char;    {this is the first one declared}
@z
@x
  @<Process a possible command line@>
@y
  @<Process a possible command line@>
  @<Initialize variables depending on Kanji code@>
@z

@x
    zen_ten,
    zen_period,
    zen_question,
    zen_exclamation:
        if( str_pool[sp_ptr-1] = zen_pun_first ) then
            repush_string
        else
            @<Add the |period| (it's necessary) and push@>;
    othercases
        @<Add the |period| (it's necessary) and push@>
@y
    othercases
        begin
        if (is_internalEUC) then
            begin
            case (fromBUFF(str_pool, sp_ptr+1, sp_ptr-1)) of
                e_kuten,
                e_period,
                e_question,
                e_exclamation:
                    if (str_pool[sp_ptr-2]<>e_ss3) then
                       repush_string
                    else
                       @<Add the |period| (it's necessary) and push@>;
                othercases
                    @<Add the |period| (it's necessary) and push@>;
            endcases;
            end;
        if (is_internalUPTEX) then
            begin
            case (fromBUFF(str_pool, sp_ptr+1, sp_ptr-2)) of
                u_kuten,
                u_period,
                u_question,
                u_exclamation,
                u_double_question,
                u_double_exclam,
                u_interrobang,
                u_question_exclam,
                u_exclam_question:
                    repush_string;
                othercases
                    @<Add the |period| (it's necessary) and push@>;
            endcases;
            end;
        end;
@z

@x x_chr_to_int
        push_lit_stk(toDVI(fromBUFF(str_pool, str_start[pop_lit1]+2, str_start[pop_lit1])),stk_int)
                                        { a KANJI char is 2byte long }
@y
        push_lit_stk(toDVI(fromBUFF(str_pool, str_start[pop_lit1]+length(pop_lit1), str_start[pop_lit1])),stk_int)
                                        { a KANJI char is |2..4|byte long }
@z

@x
    if( (ex_buf[ex_buf_ptr-1]=zen_comma) or (ex_buf[ex_buf_ptr-1]=zen_kuten) )
    then ex_buf_ptr := ex_buf_ptr - 2
    else ex_buf_ptr := ex_buf_ptr - 4;
@y
    if (is_internalEUC) then
      if((fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr-2) = e_comma) or
         (fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr-2) = e_toten))
      then ex_buf_ptr := ex_buf_ptr - 2
      else ex_buf_ptr := ex_buf_ptr - 4;
    if (is_internalUPTEX) then
      if((fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr-3) = u_comma) or
         (fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr-3) = u_toten))
      then ex_buf_ptr := ex_buf_ptr - 3
      else ex_buf_ptr := ex_buf_ptr - 4;
@z

@x
     zen_pun_first:
        begin
          if((ex_buf[ex_buf_ptr+1]=zen_comma) or
             (ex_buf[ex_buf_ptr+1]=zen_kuten) ) then
@y
     e_pun_first:
        if (is_internalEUC) then
        begin
          if ((fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr) = e_comma) or 
              (fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr) = e_toten)) then
@z
@x
          else if(ex_buf[ex_buf_ptr+1]=zen_space) then
@y
          else if (fromBUFF(ex_buf,ex_buf_length,ex_buf_ptr) = e_space) then
@z
@x
        end;
@y
        end else begin
            ex_buf_ptr := ex_buf_ptr + multibytelen(ex_buf[ex_buf_ptr]);
            preceding_white := false;
        end;
     u_pun_first1,
     u_pun_first2:
        if (is_internalUPTEX) then
        begin
          if ((fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr) = u_comma) or 
              (fromBUFF(ex_buf, ex_buf_length, ex_buf_ptr) = u_toten)) then
                begin
                  preceding_white := false;
                  and_found  := true
                end
          else if (fromBUFF(ex_buf,ex_buf_length,ex_buf_ptr) = u_space) then
               begin
                  ex_buf[ex_buf_ptr]   := space;
                  ex_buf[ex_buf_ptr+1] := space;
                  ex_buf[ex_buf_ptr+2] := space;
                  preceding_white := true;
               end;
          ex_buf_ptr := ex_buf_ptr + 3;
        end else begin
            ex_buf_ptr := ex_buf_ptr + multibytelen(ex_buf[ex_buf_ptr]);
            preceding_white := false;
        end;
@z

@x
                if( ex_buf[ex_buf_ptr] > 127 ) then
                        ex_buf_ptr := ex_buf_ptr +2
                else
                        incr(ex_buf_ptr);
@y
            ex_buf_ptr := ex_buf_ptr + multibytelen(ex_buf[ex_buf_ptr]);
@z

@x
            if name_buf[name_bf_ptr]>127 then begin
                append_ex_buf_char_and_check (name_buf[name_bf_ptr]);
                incr(name_bf_ptr);
                append_ex_buf_char_and_check (name_buf[name_bf_ptr]);
            end
            else
                append_ex_buf_char_and_check (name_buf[name_bf_ptr]);
@y
        append_ex_buf_char_and_check (name_buf[name_bf_ptr]);
        if multibytelen(name_buf[name_bf_ptr]) > 1 then
            append_ex_buf_char_and_check (name_buf[name_bf_ptr+1]);
        if multibytelen(name_buf[name_bf_ptr]) > 2 then
            append_ex_buf_char_and_check (name_buf[name_bf_ptr+2]);
        if multibytelen(name_buf[name_bf_ptr]) > 3 then
            append_ex_buf_char_and_check (name_buf[name_bf_ptr+3]);
        name_bf_ptr := name_bf_ptr + multibytelen(name_buf[name_bf_ptr])-1;
@z

@x x_int_to_chr
    str_room(2);
    if (pop_lit1>127) then begin
        append_char (Hi(k));
        append_char (Lo(k));
    end
    else
        append_char (pop_lit1);
    push_lit_stk (make_string, stk_str);
    end;
@y
    str_room(4);
    k:=toBUFF(k);
    if (BYTE1(k)>0) then
        append_char (BYTE1(k));
    if (BYTE2(k)>0) then
        append_char (BYTE2(k));
    if (BYTE3(k)>0) then
        append_char (BYTE3(k));
    { always }
        append_char (BYTE4(k));
    push_lit_stk (make_string, stk_str);
    end;
@z

@x
@!pop_lit2_saved: integer;
@y
@!pop_lit2_saved,@!mbl_tpe: integer;
@z

@x
{ 2 bytes Kanji code break check }
tps:=str_start[pop_lit3];
tpe:=tps;
while tpe < str_start[pop_lit3+1] do begin
    if str_pool[tpe] > 127 then begin
        if str_start[pop_lit3+1] < tpe+2 then
            break;
        tpe := tpe + 2;
        end
    else begin
        if str_start[pop_lit3+1] < tpe+1 then
            break;
        tpe := tpe + 1;
        end;
    if tpe<=sp_ptr then
        tps := tpe;
    if sp_end<=tpe then break;
end;
if (pop_lit2_saved > 1) and (tps = str_start[pop_lit3])
    then tps := tps + 2; {truncate at least one}
if (pop_lit2_saved < -1) and (tpe = str_start[pop_lit3+1])
    then tpe := tpe - 2; {truncate at least one}
if tps > tpe then tpe := tps;
sp_ptr := tps;
sp_end := tpe;
@y
{ |2..4| bytes Kanji code break check }
tps:=str_start[pop_lit3];
tpe:=tps;
mbl_tpe:=0;
while tpe < str_start[pop_lit3+1] do begin
    if multibytelen(str_pool[tpe])<0 {just in case}
        or (str_start[pop_lit3+1] < tpe+multibytelen(str_pool[tpe])) then
        break;
    mbl_tpe := multibytelen(str_pool[tpe]);
    tpe := tpe + mbl_tpe;
    if tpe<=sp_ptr then
        tps := tpe;
    if sp_end<=tpe then break;
end;
if (pop_lit2_saved > 1) and (tps = str_start[pop_lit3]) then
    if multibytelen(str_pool[tps])>=0 then {just in case}
        tps := tps + multibytelen(str_pool[tps]); {truncate at least one}
if (pop_lit2_saved < -1) and (tpe = str_start[pop_lit3+1]) then
    tpe := tpe - mbl_tpe; {truncate at least one}
if tps > tpe then tpe := tps;
sp_ptr := tps;
sp_end := tpe;
@z

@x
    if str_pool[sp_ptr] >127 then begin
         append_char (str_pool[sp_ptr]); incr(sp_ptr);
         append_char (str_pool[sp_ptr]); incr(sp_ptr);
         end
    else begin
         append_char (str_pool[sp_ptr]); incr(sp_ptr);
         end;
@y
    append_char (str_pool[sp_ptr]);
    incr(sp_ptr);
@z

@x
            incr(sp_xptr1); num_text_chars:=num_text_chars+2;
@y
            num_text_chars := num_text_chars + multibytelen(str_pool[sp_xptr1-1]);
            sp_xptr1 := sp_xptr1-1 + multibytelen(str_pool[sp_xptr1-1]);
@z

@x
const n_options = 8; {Pascal won't count array lengths for us.}
@y
const n_options = 9; {Pascal won't count array lengths for us.}
@z

@x
      usage_help (PBIBTEX_HELP, 'issue@@texjp.org');
@y
      usage_help (UPBIBTEX_HELP, 'issue@@texjp.org');
@z

@x
    end; {Else it was a flag; |getopt| has already done the assignment.}
@y
    end else if argument_is ('kanji-internal') then begin
      if (not (set_enc_string(nil,optarg) and
               (is_internalEUC or is_internalUPTEX))) then
        write_ln('Bad internal kanji encoding "', stringcast(optarg), '".');

    end; {Else it was a flag; |getopt| has already done the assignment.}
@z

@x
@ An element with all zeros always ends the list.
@y
@ Kanji-internal option.
@.-kanji-internal@>

@<Define the option...@> =
long_options[current_option].name := 'kanji-internal';
long_options[current_option].has_arg := 1;
long_options[current_option].flag := 0;
long_options[current_option].val := 0;
incr(current_option);

@ An element with all zeros always ends the list.
@z

@x
begin kpse_set_program_name (argv[0], 'pbibtex');
@y
begin kpse_set_program_name (argv[0], 'upbibtex');
@z

@x procedure x_is_kanji_str
procedure x_is_kanji_str;
label exit;
@y
procedure x_is_kanji_str;
label exit;
var ctmp,clen:integer;
@z

@x procedure x_is_kanji_str (cont.)
        while sp_ptr<sp_end do begin
            if str_pool[sp_ptr]>127 then begin
                push_lit_stk(1,stk_int);
                return;
            end else begin
                incr(sp_ptr);
            end;
        end;
@y
        while sp_ptr<sp_end do begin
            clen := multibytelen(str_pool[sp_ptr]);
            if sp_ptr+clen<=sp_end then
                ctmp := fromBUFF(str_pool, sp_ptr+clen, sp_ptr)
            else
                ctmp := str_pool[sp_ptr];
            if is_char_kanji_upbibtex(ctmp) then begin
                push_lit_stk(1,stk_int);
                return;
            end else begin
                if sp_ptr+clen<=sp_end then
                    sp_ptr := sp_ptr + clen
                else
                    incr(sp_ptr);
            end;
        end;
@z

@x
exit:end;
@y
exit:end;

@ @<Procedures and functions for handling numbers, characters, and strings@>=
function is_char_kanji_upbibtex(@!c:integer):boolean;
label exit;
var k:integer;
begin
  { based on upTeX-1.29 kcatcode status: 16,17,19->true / 15,18->false }
  is_char_kanji_upbibtex := true;
  if (is_internalUPTEX) then begin { should be in sync with |kcat_code| of uptex-m.ch }
    k := kcatcodekey(c);
    if k=@"25 then return { Hangul Jamo }
    else if (k>=@"68)and(k<=@"69) then return { CJK Radicals Supplement, Kangxi Radicals }
    else if (k>=@"6C)and(k<=@"6D) then return { Hiragana, Katakana }
    else if k=@"6E then return { Bopomofo }
    else if k=@"6F then return { Hangul Compatibility Jamo }
    else if (k>=@"70)and(k<=@"72) then return { Kanbun .. CJK Strokes }
    else if k=@"73 then return { Katakana Phonetic Extensions }
    else if k=@"76 then return { CJK Unified Ideographs Extension A }
    else if k=@"78 then return { CJK Unified Ideographs }
    else if k=@"88 then return { Hangul Jamo Extended-A }
    else if k=@"93 then return { Hangul Syllables }
    else if k=@"94 then return { Hangul Jamo Extended-B }
    else if k=@"99 then return { CJK Compatibility Ideographs }
    else if (k>=@"10D)and(k<=@"110) then return { Kana Extended-B .. Small Kana Extension }
    else if (k>=@"13B)and(k<=@"142) then return { CJK Unified Ideographs Extension B .. H }
    else if k=@"1FE then return { Fullwidth digit and latin alphabet }
    else if k=@"1FF then return; { Halfwidth katakana }
    end
  else { is_internalEUC }
    if is_char_kanji(c) then return;
  is_char_kanji_upbibtex := false;
exit:end;

@ @<Initialize variables depending on Kanji code@>=
if (is_internalUPTEX) then
  begin
    for i:=@"80 to @"BF do lex_class[i] := alpha; { trail bytes }
    for i:=@"C0 to @"C1 do lex_class[i] := illegal;
    for i:=@"C2 to @"F4 do lex_class[i] := alpha; { lead bytes }
    for i:=@"F5 to @"FF do lex_class[i] := illegal;
    for i:=@"C0 to @"C1 do id_class[i] := illegal_id_char;
    for i:=@"F5 to @"FF do id_class[i] := illegal_id_char;
    for i:=@"80 to @"BF do char_width[i]:=257; { trail bytes }
    for i:=@"C2 to @"DF do char_width[i]:=771; { lead bytes (2bytes) }
    for i:=@"E0 to @"EF do char_width[i]:=514; { lead bytes (3bytes) }
    for i:=@"F0 to @"F4 do char_width[i]:=257; { lead bytes (4bytes) }
  end
else
  begin { is_internalEUC }
    for i:=@'200 to @'240 do lex_class[i] := illegal;
    for i:=@'241 to 254 do lex_class[i] := alpha;
    lex_class[255]:=illegal;
    for i:=@'200 to @'240 do id_class[i] := illegal_id_char;
    id_class[255]:=illegal_id_char;
    lex_class[@'33]:=alpha;
    lex_class[e_ss3]:=alpha;
    for i:=@'241 to 254 do char_width[i]:=514;
    char_width[e_ss3]:=0;
  end;
@z

