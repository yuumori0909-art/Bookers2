import Raty from "raty-js"

document.addEventListener("turbo:load", () => {
  // --- 1. 新規投稿用（入力） ---
  const postElem = document.querySelector("#post_raty");
  if (postElem) {
    postElem.innerHTML = "";
    new Raty(postElem, {
      scoreName: "book[score]",
      starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-on.png",
      starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-off.png",
      starHalf: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-half.png",
    }).init();
  }

  // --- 2. 詳細画面用（表示のみ） ---
  const showElem = document.querySelector("#show_raty");
  if (showElem) {
    showElem.innerHTML = "";
    new Raty(showElem, {
      score: showElem.dataset.score, // HTMLの data-score から点数を取得
      readOnly: true,                // 変更できないようにする
      starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-on.png",
      starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-off.png",
      starHalf: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-half.png",
    }).init();
  }

  // --- 3. 一覧・繰り返し用（複数表示） ---
    const starElems = document.querySelectorAll(".star-group");
    starElems.forEach((elem) => {
      elem.innerHTML = "";
      new Raty(elem, {
        score: elem.dataset.score,
        readOnly: true,
        starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-on.png",
        starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-off.png",
        starHalf: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.0/images/star-half.png",
      }).init();
    });
}); 