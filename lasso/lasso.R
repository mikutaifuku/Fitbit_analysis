#
#  date : 2018/03/02
#  
#  mikutaifuku
#
#  lasso.R
#
#  Fitbitデータでスパース推定入門
#
#  lassoによる変数選択
#

# set library ====
library("tidyverse")
library("glmnet")
library("ggthemes")
library("ggfortify")

# read data ====
df <- read_csv(file="data/merge.csv",
               col_names=TRUE, locale = locale(encoding="CP932")) %>% 
  select(-Date, -totalSleepRecords, -day, -steps, -totalMinutesAsleep, -Tobacco)

# lasso ====
# 「睡眠効率に影響を与える変数を探る」
# lassoを用いて睡眠効率に影響を与える変数を選択

y <- unlist(select(df, efficiency))
x <- scale(as.matrix(select(df, -efficiency)))

fit <- glmnet(x, y, standardize = FALSE)
plot(fit, label = TRUE)
autoplot(fit) + theme_pander() + scale_color_pander()

# cv lasso ====
set.seed(0)
cvfit <- cv.glmnet(x, y, standardize = FALSE, nfolds = 10)
autoplot(cvfit) + theme_pander() + scale_color_pander()

coef(cvfit, s = "lambda.min")
