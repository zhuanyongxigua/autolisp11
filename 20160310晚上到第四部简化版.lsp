(setq cmdecho_bak (getvar "cmdecho"))     ;�ر�������ʾ
(setvar "cmdecho" 0)
(vl-load-com)
;;;(setq osmode_bak (getvar "osmode"))       ;�رն���׽���Է�ֹcommand����ȡ���ǳ���ƫ��
;;;(Setvar "osmode" 0)
(Setq MSP (Vlax-Get (Vlax-Get (Vlax-Get-Acad-Object) 'ActiveDocument) 'ModelSpace ))
(vlax-for name MSP
   (vla-put-color name 256)
   (vla-put-linetype name "BYLAYER")
   (vla-put-Lineweight name -1)
)
;;;0���3��
(setq ss (ssget "X"))
(setq changdu (sslength ss))
(setq i 0)
(repeat changdu
        (setq ent (entget (ssname ss i)))
        (setq ttt (cdr(assoc 8 ent)))
        (if (= ttt "0")
	(entmod (subst (cons 8 "3�����߲�") (assoc 8 ent) ent))
	nil
	)
	(setq i (1+ i))
)


;�Զ����Ų����޸ı�עϵͳ����
(setq wenziceng (ssget "X" '((8 . "6���ֲ�"))))
(setq i 0)
(setq changdu (sslength wenziceng))
(repeat changdu
        (setq ent (entget (ssname wenziceng i))) ;�õ�ͼԪ�����б�
        (setq wenzi (assoc 1 ent))               ;������ҪͼԪ����
	(setq wenzi2 (cdr wenzi))                ;�õ����֣�ȫ����
        (setq wenzi3 (substr wenzi2 1 4))        ;�õ����ֵ�ǰ�������֣�ǰ��λ�ַ�
        (if (= wenzi3 "����")
              (progn
	        (setq a (substr wenzi2 5 1))
		(setq b (substr wenzi2 7))
	      )
	     nil
	)
	(setq i (1+ i))
)
(setq a (atof a)) ;����ַ���ת����ʵ��Ա��������ź��޸ı���
(setq b (atof b))
(print a)
(print b)
(if (= a 1)
    (progn
     (command "_.scale" (ssget "X") "" "0,0" b "")  ;���a����1�ͷŴ�
     (setq d (* 1.25 b))  ;�����ߴ�����ֵ
     (setq e (* 2.5 b))   ;��ͷ��С��ֵ
     (setq f (* 3.5 b))   ;���ִ�С��ֵ
    )
    (progn
     (setq c (/ b a))
     (command "_.scale" (ssget "X") "" "0,0" c "")  ;���a������1����С
     (setq d (* 1.25 c))  ;�����ߴ�����ֵ
     (setq e (* 2.5 c))   ;��ͷ��С��ֵ
     (setq f (* 3.5 c))   ;���ִ�С��ֵ
    )
     
)


;------�½�����Ϊ"��ע��ʽ"�ı�ע��ʽ��������Ĭ�ϵı�ע��ʽ����

  (command "blipmode" "0"                ;����ģʽ����
           "dimadec"  "2"                ;�Ƕȱ�עС��λ����
           "dimalt"   "off"                ;���ƻ��㵥λ�Ƿ��
           "dimalttz" "1"                ;���ƶԹ���ֵ�����㴦��
           "dimaltu"  "2"                ;�������б�ע����ʽ���Ƕȱ�ע���⣩�Ļ��㵥λ�ĵ�λ��ʽ
           "dimassoc" "2"                ;���Ʊ�ע����Ĺ������Լ��Ƿ�ֽ��ע
           "dimasz"   "2.5"                ;���Ƴߴ��ߺ����߼�ͷ�Ĵ�С�������ƻ��ߵĴ�С
           "dimatfit" "3"                ;�ߴ�����ڵĿռ䲻����ͬʱ���±�ע���ֺͼ�ͷʱ����ϵͳ������ȷ�������ߵ����з�ʽ
           "dimaunit" "0"                ;���ýǶȱ�ע�ĵ�λ��ʽ
           "dimazin"  "2"                ;�ԽǶȱ�ע�������㴦��
           "dimblk"   ""                ;���óߴ���ĩ����ʾ�ļ�ͷ��
           "dimcen"   "0"                ;��עԲ�ģ�����
           "dimclrd"  "256"                ;�ߴ��ߡ���ͷ�ͱ�ע����ָ����ɫ��������� 0���������256
           "dimclre"  "256"                ;�ߴ����ָ����ɫ��������� 0���������256
           "dimclrt"  "256"                ;Ϊ��ע����ָ����ɫ
           "dimdec"   "2"                ;���ñ�ע����λ����ʾ��С��λ��
           "dimdle"   "0.00"                ;��ʹ��Сб�ߴ����ͷ���б�עʱ�����óߴ��߳����ߴ���ߵľ���
           "dimdli"   "0.05"                ;���ƻ��߱�ע�гߴ��ߵļ��
           "dimdsep"  "."                ;С���ָ���Ϊ.
           "dimexe"   "1.25"                ;ָ���ߴ��߳����ߴ���ߵľ���
           "dimexo"   "0.35"                ;ָ���ߴ����ƫ��ԭ��ľ���
           "dimfxlon" "off"                ;�����Ƿ񽫳ߴ��������Ϊ�̶�����
           "dimgap"   "0.5"                ;�ߴ��߷ֳ����δӶ�����ע���ַ���������֮��ʱ�����ñ�ע������Χ�ľ���
           "dimjust"  "0"                ;���Ʊ�ע���ֵ�ˮƽλ��
           "dimldrblk"                 ""        ;��ͷ���ߴ�30
           "dimlfac"  "1"                ;�������Ա�ע����ֵ�ı�������
           "dimlunit" "2"                ;�������б�ע���ͣ��Ƕȱ�ע���⣩�ĵ�λ
           "dimscale" "1"                ;����Ӧ���ڱ�ע��������ָ����С�������ƫ��������ȫ�ֱ�������
           "dimtad"   "1"                ;����������Գߴ��ߵĴ�ֱλ��
           "dimtdec"  "2"                ;���ñ�ע����λ�Ĺ���ֵ��Ҫ��ʾ��С��λ��
           "dimtfac"  "1"                ;ָ�������͹���ֵ�����ָ߶�����ڱ�ע���ָ߶ȵı�������
           "dimtfill" "0"                ;���Ʊ�ע���ֵı���
           "dimtfillclr"         "0"        ;���ñ�ע�����ֱ�������ɫ
           "dimtih"   "off"                ;��ע�����ڳߴ�����ڵ�λ�ã���
           "dimtix"   "off"                ;�ڳߴ����֮���������
           "dimtmove" "0"                ;���ñ�ע���ֵ��ƶ�����
           "dimtofl"  "on"                ;�����Ƿ��ڳߴ����֮����Ƴߴ���
           "dimtol"   "off"                ;������ڱ�ע����֮��
           "dimtolj"  "1"                ;���ù���ֵ����ڱ�ע���ֵĴ�ֱ������ʽ
           "dimtxsty" "STANDARD"        ;������ʽ
           "dimtxt"   "3.5"                ;���ָ߶�
           "dimtzin"  "1"                ;���ƶԹ���ֵ�����㴦��
           "dimupt"   "off"                ;�����û���λ����ѡ��
           "dimzin"   "9"                ;���ƶ�����λֵ�����㴦��
          )
(setvar "dimtxt" f)
(setvar "dimexe" d)
(setvar "dimasz" e)
  (if (not (tblsearch "dimstyle" "��ע��ʽ"))
    (command "dimstyle" "S" "��ע��ʽ")
  )

;;;�޸ı�ע���Ĭ�ϱ�ע��ʽ
(setq biaozhuceng (ssget "X" '((8 . "7��ע��"))))
(setq i 0)
(setq changdu (sslength biaozhuceng))
(repeat changdu
        (setq ent (entget (ssname biaozhuceng i))) ;�õ�ͼԪ�����б�
        (setq aaa (cdr(assoc 3 ent)))
        (if (= aaa "��ע��ʽ")
	 nil
	(entmod (subst (cons 3 "��ע��ʽ") (assoc 3 ent) ent))
	)
	(setq i (1+ i))
)

(setvar "cmdecho" cmdecho_bak) ;����������ʾ
;;;(Setvar "osmode" osmode_bak)   ;���ض���׽





