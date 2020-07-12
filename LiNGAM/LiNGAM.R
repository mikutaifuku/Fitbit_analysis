#
#  date : 2018/02/08
#  
#  mikutaifuku
#
#  LiNGAM.R
#
#  Fitbitデータ分析
#
#  LiNGAMを用いた因果探索
#

# ---- set library ====
library("dplyr")
library("tidyr")
library("readr")
library("ggplot2")
library("ggthemes")
library("scales")
library("lubridate")
library("graph")
library("pcalg")

# ---- example 1 LINGAM ====
set.seed(1234)
n <- 500
eps1 <- sign(rnorm(n)) * sqrt(abs(rnorm(n)))
eps2 <- runif(n) - 0.5

x2 <- 3 + eps2
x1 <- 0.9*x2 + 7 + eps1

#truth: x1 <- x2
trueDAG <- cbind(c(0,1),c(0,0))

X <- cbind(x1,x2)
res <- lingam(X)

cat("true DAG:\n")
show(trueDAG)

cat("estimated DAG:\n")
as(res, "amat")

cat("\n true constants:\n")
show(c(7,3))
cat("estimated constants:\n")
show(res$ci)

cat("\n true (sample) noise standard deviations:\n")
show(c(sd(eps1), sd(eps2)))
cat("estimated noise standard deviations:\n")
show(res$stde)

# ---- read data ====
steps_calory_df <- read_csv(file="data/steps_calory.csv", col_names=TRUE, locale = locale(encoding="CP932")) 
# > dim(steps_calory_df)
# [1] 365    3

# ---- processing ====
X <- steps_calory_df %>% filter(steps>=1000)
X <- steps_calory_df %>% filter(date>=ymd("2017-10-01"))

X <- cbind(steps=steps_calory_df[["steps"]], caloriesOut=steps_calory_df[["caloriesOut"]])
X <- cbind(steps=scale(steps_calory_df[["steps"]]), caloriesOut=scale(steps_calory_df[["caloriesOut"]]))

# ---- LiNGAM ====
lingam(scale(X))
