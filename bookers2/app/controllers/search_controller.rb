class SearchController < ApplicationController

  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
  end
  # 選択したmodelを@modelに代入する
  # 検索にかけた文字列(ここではvalue)を@valueに代入する
  # 選択した検索方法howを@howに代入する
  # search_forの引数にインスタンス変数を定義する
  # 検索結果を@datasに代入する

  private

  def match(model, value)
    if model == 'user'
      User.where(name: value)
    elsif model == 'book'
      Book.where(title: value)
    end
  end

  # 完全一致
  # モデル名.where("カラム名 LIKE ?", "値%")

  def forward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end

  # 前方一致
  # モデル名.where("カラム名 LIKE ?", "値%")

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  # 後方一致
  # モデル名.where("カラム名 LIKE ?", "%値")

  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end

  # 部分一致
  # モデル名.where("カラム名 LIKE ?", "%値%")

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end
  # searchアクションで定義した情報が引数に入っている
  # 検索方法のhowの中身がどれなのかwhenの条件分岐の中から探す処理を行う
  # 検索方法の引数に(model, value)を定義している
  # howがmatchの場合はdef matchの処理へ進む