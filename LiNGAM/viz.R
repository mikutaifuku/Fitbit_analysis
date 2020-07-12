#
#  date : 2018/02/15
#  
#  mikutaifuku
#
#  viz.R
#
#  Fitbitデータ分析
#
#  歩数データと消費カロリーデータの可視化
#

# ---- set library ====
library("dplyr")
library("tidyr")
library("readr")
library("ggplot2")
library("ggthemes")
library("scales")
library("lubridate")

# ---- read data ====
steps_calory_df <- read_csv(file="data/steps_calory.csv", col_names=TRUE, locale = locale(encoding="CP932")) 
# > dim(steps_calory_df)
# [1] 365    3

# ---- plot ====
p1 <- ggplot(data = steps_calory_df, aes(steps, caloriesOut)) + 
  geom_point(color = "darkgrey", fill = "darkgrey", alpha=0.5) + 
  theme_pander(base_size = 8) + 
  xlab("Steps") + ylab("CaloriesOut")
plot(p1) 

p2 <- ggplot(data = steps_calory_df, aes(steps)) + 
  geom_histogram(fill = "blue", alpha=0.5) + 
  theme_pander(base_size = 8) + 
  xlab("Steps") + ylab("Count")
plot(p2) 

p3 <- ggplot(data = steps_calory_df, aes(caloriesOut)) + 
  geom_histogram(fill = "red", alpha=0.5) + 
  theme_pander(base_size = 8) + 
  xlab("caloriesOut") + ylab("Count")
plot(p3) 

# ---- save ====
ggsave(file = "point_Steps_CaloriesOut.png", plot = p1, dpi = 300, width = 4, height = 4)
ggsave(file = "histgram_Steps.png", plot = p2, dpi = 300, width = 4, height = 3)
ggsave(file = "histgram_CaloriesOut.png", plot = p3, dpi = 300, width = 4, height = 3)
