# 100本ノック　学んだことまとめ

## pandas.関数

### pd.concat( )

```pandas.DataFrame```や```pandas.Series```を連結することができる。

```python
pd.concat( [df1,df2], axis=0 or 1, join='条件' )
```

第一引数に連結したい```pandas.DataFrame```と```pandas.Series```を**リスト**または**タプル**で指定する。
第二引数は、```axis=0```とすることで縦向きに結合し（これがデフォルト）、```axis=1```とすることで横方向に結合する。
第三引数は、結合の仕方を指定できる。```条件文```に入るのは次の二つ。

- ```inner``` 内部結合。共通の列・行のみが残る。
- ```outer``` 外部結合。すべての行・列が残る。

### pd.to_datetime( )

日時を表した文字列の```pandas.Series```を```Timestamp```型に変換する。

```python
pd.to_datetime(df['列名'], format='書式')
```

```format```を指定しない場合、```yyyy-mm-dd 00:00:00```として返ってくる。```format```の書式は次の通り。

- ```%Y``` 年
- ```%m``` 月
- ```%d``` 日
- ```%H``` 時間
- ```%M``` 分
- ```%S``` 秒
- ```%w``` 整数表記された曜日（0:日曜日）

#### dtアクセサ

```pansdas.Series```全体に日時処理を適用するアクセサ。年月日、曜日などを抽出でき、```pandas.Series```が返ってくる。

```python
pd.to_datetime(df['列名'], format='書式').dt.属性
```

属性には次のようなものがある。

- ```year``` 年
- ```month``` 月
- ```day``` 日
- ```hour``` 時間
- ```minute``` 分
- ```second``` 秒
- ```week_name``` 曜日（文字列）
- ```dayofweek``` 曜日（数値）

## DataFrame.メソッド

### agg( )

引数に適用したい関数や処理を**リスト**で指定すると、各列で処理が行われて```pandas.DataFrame```型が返ってくる。

```python
df.agg([ '処理1', '処理2', ... ])
```

要素数が一つでもリストで指定した場合は```pandas.DataFrame```型が返ってくる。リストではなく文字列を単独で指定した場合は```pandas.Series```型が返ってくる。

さらに、```key```を列名、```value```を適用する処理とした**辞書型**を指定すると各列に異なる処理を行うことができる。

```python
df.agg({'列名1' : ['処理1', '処理2'], '列名2' : ['処理3', '処理4']})
```

```処理```の部分は自作した関数や```lambda```式なども用いることができる。

### groupby( )

データをグルーピングする。さらに、その後各グループ内での平均、最小値、最大値、合計などを算出したり、任意の関数で処理することが可能である。```GroupBy```オブジェクトとして返ってくる。

```python
df.groupby('列名')
```

さらに、これに対して様々な統計量を算出するためのメソッドがある。

```python
df.groupby('列名').メソッド
```

メソッドには次のものがあり、各グループの値を返す。

- ```min()``` 最小値
- ```max()``` 最大値
- ```sum()``` 合計値
- ```mean()``` 平均値
- ```std()``` 標準偏差
- ```var()``` 分散

### sort_values( )

要素でソートし、```pandas.DataFrame```型を返す。

```python
df.sort_values( 'カラム名', acsending = True or False )
```

デフォルトは昇順で、```acsending = False```とすることで降順にできる。

その他は次を参照：
<https://note.nkmk.me/python-pandas-sort-values-sort-index/>

### query( )

DataFrameの行を条件で抽出し、```pandas.DataFrame```型を返す。

```python
df.query( '条件文', engine='python' )
```

条件の出し方は以下のようになる。

- 比較演算子 ```amount >= 1000``` など
- in演算子で指定 ```state in ["NY","TX"]``` など
- indexに対する条件 ```index % 2 == 0``` など
- 文字列メソッドで指定 以下に示す

その他の条件指定方法は次を参照：
<https://note.nkmk.me/python-pandas-query/>

#### 文字列メソッド str.~~~( )

DataFrameの列なかである文字列に関する条件を満たすものを取り出す。

- ```str.startswith()``` 特定の文字列で始める
- ```str.endswith()``` 特定の文字列で終わる
- ```str.contains()``` 特定の文字列を含む
- ```str.contains()``` 正規表現に一致する

#### 正規表現

文字の並びの条件を簡単に記述する方法。

参照：
<https://qiita.com/hiroyuki_mrp/items/29e87bf5fe46de62983c>

### rank( )

デフォルトでは指定した列が昇順で順位付けされる。

```python
df['カラム名'].rank( axis=0 or 1, numeric_only=True, ascending=False, method='average' )
```

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

### rename( )

列と行で分けて**辞書型**によって名前の変更を行う。

```python
df.rename( colunms={'A':'B', 'C':'D'}, index={'E':'F'}, inplace=True )
```

このように書くと列名の```A```と```B```をそれぞれ```C```と```D```に変更し、行名を```E```から```F```に変更する。デフォルトでは新しい```pandas.DataFrame```が返されるが、上のように```inplace=True```とすることで元の```pandas.DataFrame```が変更される。

また、```lambda```式を用いて変更することもできる。

```python
df.rename( colunms=lambda x: x * 2, index={'E':'F'}, inplace=True )
```
