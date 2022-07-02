window.addEventListener('DOMContentLoaded', () => {
  set_book_rater()
})
window.addEventListener('turbolinks:load', () => {
  set_book_rater()
})

const set_book_rater = () => {
  if (document.querySelector("#book-rater").innerHTML == '') {
    const book_rater = rater({
      element: document.querySelector("#book-rater"),
      max: 5,
      starSize: 20,
      rateCallback: (rating, done) => {
        book_rater.setRating(rating)
        $('#book_rating').val(rating)
        done()
      }
      })
  }
}
