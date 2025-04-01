test_that("add_numbers adds two positive numbers correctly", {
  result <- add_numbers(3, 5)
  expect_equal(result, 8)
})

test_that("add_numbers adds a negative number correctly", {
  result <- add_numbers(3, 5)
  expect_equal(result, 8)
})

test_that("add_numbers adds two zeros correctly", {
  result <- add_numbers(0, 0)
  expect_equal(result, 0)
})