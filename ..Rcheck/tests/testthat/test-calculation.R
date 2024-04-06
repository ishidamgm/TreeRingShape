# test-calculation.R

#slotNames(TR)
test_that("test area",{
  expect_equal(TreeRingShape::area(TR@L[[1]]),253029356)
}


)

