(setq cmdecho_bak (getvar "cmdecho"))     ;关闭命令提示
(setvar "cmdecho" 0)
(vl-load-com)
;;;(setq osmode_bak (getvar "osmode"))       ;关闭对象捕捉，以防止command命令取点是出现偏差
;;;(Setvar "osmode" 0)
(Setq MSP (Vlax-Get (Vlax-Get (Vlax-Get-Acad-Object) 'ActiveDocument) 'ModelSpace ))
(vlax-for name MSP
   (vla-put-color name 256)
   (vla-put-linetype name "BYLAYER")
   (vla-put-Lineweight name -1)
)
;;;0层改3层
(setq ss (ssget "X"))
(setq changdu (sslength ss))
(setq i 0)
(repeat changdu
        (setq ent (entget (ssname ss i)))
        (setq ttt (cdr(assoc 8 ent)))
        (if (= ttt "0")
	(entmod (subst (cons 8 "3中心线层") (assoc 8 ent) ent))
	nil
	)
	(setq i (1+ i))
)


;自动缩放并且修改标注系统变量
(setq wenziceng (ssget "X" '((8 . "6文字层"))))
(setq i 0)
(setq changdu (sslength wenziceng))
(repeat changdu
        (setq ent (entget (ssname wenziceng i))) ;得到图元属性列表
        (setq wenzi (assoc 1 ent))               ;查找需要图元属性
	(setq wenzi2 (cdr wenzi))                ;得到文字，全文字
        (setq wenzi3 (substr wenzi2 1 4))        ;得到文字的前两个文字，前四位字符
        (if (= wenzi3 "比例")
              (progn
	        (setq a (substr wenzi2 5 1))
		(setq b (substr wenzi2 7))
	      )
	     nil
	)
	(setq i (1+ i))
)
(setq a (atof a)) ;提出字符串转化成实物，以备后面缩放和修改比例
(setq b (atof b))
(print a)
(print b)
(if (= a 1)
    (progn
     (command "_.scale" (ssget "X") "" "0,0" b "")  ;如果a等于1就放大
     (setq d (* 1.25 b))  ;超出尺寸线数值
     (setq e (* 2.5 b))   ;箭头大小数值
     (setq f (* 3.5 b))   ;文字大小数值
    )
    (progn
     (setq c (/ b a))
     (command "_.scale" (ssget "X") "" "0,0" c "")  ;如果a不等于1就缩小
     (setq d (* 1.25 c))  ;超出尺寸线数值
     (setq e (* 2.5 c))   ;箭头大小数值
     (setq f (* 3.5 c))   ;文字大小数值
    )
     
)


;------新建名称为"标注样式"的标注样式，并定义默认的标注样式参数

  (command "blipmode" "0"                ;点标记模式：关
           "dimadec"  "2"                ;角度标注小数位精度
           "dimalt"   "off"                ;控制换算单位是否打开
           "dimalttz" "1"                ;控制对公差值的消零处理
           "dimaltu"  "2"                ;设置所有标注子样式（角度标注除外）的换算单位的单位格式
           "dimassoc" "2"                ;控制标注对象的关联性以及是否分解标注
           "dimasz"   "2.5"                ;控制尺寸线和引线箭头的大小。并控制基线的大小
           "dimatfit" "3"                ;尺寸界线内的空间不足以同时放下标注文字和箭头时，此系统变量将确定这两者的排列方式
           "dimaunit" "0"                ;设置角度标注的单位格式
           "dimazin"  "2"                ;对角度标注进行消零处理
           "dimblk"   ""                ;设置尺寸线末端显示的箭头块
           "dimcen"   "0"                ;标注圆心：不标
           "dimclrd"  "256"                ;尺寸线、箭头和标注引线指定颜色。随块输入 0，随层输入256
           "dimclre"  "256"                ;尺寸界线指定颜色。随块输入 0，随层输入256
           "dimclrt"  "256"                ;为标注文字指定颜色
           "dimdec"   "2"                ;设置标注主单位中显示的小数位数
           "dimdle"   "0.00"                ;当使用小斜线代替箭头进行标注时，设置尺寸线超出尺寸界线的距离
           "dimdli"   "0.05"                ;控制基线标注中尺寸线的间距
           "dimdsep"  "."                ;小数分隔符为.
           "dimexe"   "1.25"                ;指定尺寸线超出尺寸界线的距离
           "dimexo"   "0.35"                ;指定尺寸界线偏离原点的距离
           "dimfxlon" "off"                ;控制是否将尺寸界线设置为固定长度
           "dimgap"   "0.5"                ;尺寸线分成两段从而将标注文字放置在两段之间时，设置标注文字周围的距离
           "dimjust"  "0"                ;控制标注文字的水平位置
           "dimldrblk"                 ""        ;箭头引线打开30
           "dimlfac"  "1"                ;设置线性标注测量值的比例因子
           "dimlunit" "2"                ;设置所有标注类型（角度标注除外）的单位
           "dimscale" "1"                ;设置应用于标注变量（可指定大小、距离或偏移量）的全局比例因子
           "dimtad"   "1"                ;控制文字相对尺寸线的垂直位置
           "dimtdec"  "2"                ;设置标注主单位的公差值中要显示的小数位数
           "dimtfac"  "1"                ;指定分数和公差值的文字高度相对于标注文字高度的比例因子
           "dimtfill" "0"                ;控制标注文字的背景
           "dimtfillclr"         "0"        ;设置标注中文字背景的颜色
           "dimtih"   "off"                ;标注文字在尺寸界线内的位置：关
           "dimtix"   "off"                ;在尺寸界线之间绘制文字
           "dimtmove" "0"                ;设置标注文字的移动规则
           "dimtofl"  "on"                ;控制是否在尺寸界线之间绘制尺寸线
           "dimtol"   "off"                ;将公差附在标注文字之后
           "dimtolj"  "1"                ;设置公差值相对于标注文字的垂直对正方式
           "dimtxsty" "STANDARD"        ;文字样式
           "dimtxt"   "3.5"                ;文字高度
           "dimtzin"  "1"                ;控制对公差值的消零处理
           "dimupt"   "off"                ;控制用户定位文字选项
           "dimzin"   "9"                ;控制对主单位值的消零处理
          )
(setvar "dimtxt" f)
(setvar "dimexe" d)
(setvar "dimasz" e)
  (if (not (tblsearch "dimstyle" "标注样式"))
    (command "dimstyle" "S" "标注样式")
  )

;;;修改标注层的默认标注样式
(setq biaozhuceng (ssget "X" '((8 . "7标注层"))))
(setq i 0)
(setq changdu (sslength biaozhuceng))
(repeat changdu
        (setq ent (entget (ssname biaozhuceng i))) ;得到图元属性列表
        (setq aaa (cdr(assoc 3 ent)))
        (if (= aaa "标注样式")
	 nil
	(entmod (subst (cons 3 "标注样式") (assoc 3 ent) ent))
	)
	(setq i (1+ i))
)

(setvar "cmdecho" cmdecho_bak) ;返回命令提示
;;;(Setvar "osmode" osmode_bak)   ;返回对象捕捉





