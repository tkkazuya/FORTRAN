# 100本ノック　学んだことまとめ

## pandas

### query( )

DataFrameの行を条件で抽出し、DataFrame型を返す。

```df.query( '条件文', engine='python' )```

条件の出し方は以下のようになる。

- 比較演算子 ```amount >= 1000``` など
- in演算子で指定 ```state in ["NY","TX"]``` など
- indexに対する条件 ```index % 2 == 0``` など
- 文字列メソッドで指定 以下に示す

その他の条件指定方法は以下を参照
<https://note.nkmk.me/python-pandas-query/>

#### 文字列メソッド str.~~~( )

DataFrameの列なかである文字列に関する条件を満たすものを取り出す。

- ```str.startswith()``` 特定の文字列で始める
- ```str.endswith()``` 特定の文字列で終わる
- ```str.contains()``` 特定の文字列を含む
- ```str.contains()``` 正規表現に一致する

### sort_values( )

要素でソートする。

```df.sort_values( 'カラム名', acsending = True or False )```

デフォルトは昇順で、```acsending = False```とすることで降順にできる。

その他は以下を参照
<https://note.nkmk.me/python-pandas-sort-values-sort-index/>

### rank( )

デフォルトでは指定したカラムが昇順で順位付けされる。

```df['カラム名'].rank( axis=1, numeric_only=True, ascending=False, method='average' )```

- ```axis = 1``` 同一行のランク付け
- ```numeric_only = True``` 数値のみを対象
- ```acsending = False``` 降順に変更
- ```method = '処理名'``` 同一値の処理を指定```処理名```は以下の通り。
    - ```average``` 平均値
    - ```min``` 最小値
    - ```max``` 最大値
    - ```first``` 登録順（ただし、数値のみに有効）
    - ```dense``` 最小値だが、後続が詰めて順位付けされる（1位、2位タイ、2位タイ...のようになる）

その他は以下を参照
<https://note.nkmk.me/python-pandas-rank/>
