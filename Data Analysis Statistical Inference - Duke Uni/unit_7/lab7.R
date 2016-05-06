load(url("http://www.openintro.org/stat/data/evals.RData"))

summary(evals$score)
hist(evals$score)
evals$score[which(evals$score < 3)]

plot(evals$score ~ evals$bty_avg)
plot(jitter(evals$score) ~ evals$bty_avg)

m_bty <- lm(score ~ bty_avg, data = evals)

abline(m_bty)

hist(m_bty$residuals)
qqnorm(m_bty$residuals)
qqline(m_bty$residuals)
plot(m_bty$residuals ~ evals$bty_avg)

plot(evals$bty_avg ~ evals$bty_f1lower)
cor(evals$bty_avg, evals$bty_f1lower)

plot(evals[,13:19])

m_bty_gen <- lm(score ~ bty_avg + gender, data = evals)
summary(m_bty_gen)

hist(m_bty_gen$residuals)
qqnorm(m_bty_gen$residuals)
qqline(m_bty_gen$residuals)
plot(m_bty_gen$residuals ~ m_bty_gen$fitted)

multiLines(m_bty_gen)

m_bty_rank <- lm(score ~ bty_avg + rank, data = evals)
summary(m_bty_rank)

m_full <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval 
             + cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m_full)$adj.r.squared

m1 <- lm(score ~ ethnicity + gender + language + age + cls_perc_eval 
         + cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m1)$adj.r.squared

m2 = lm(score ~ rank + gender + language + age + cls_perc_eval + 
                cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m2)$adj.r.squared

m_bty_avg <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval 
             + cls_students + cls_level + cls_profs + cls_credits, data = evals)
summary(m_bty_avg)$adj.r.squared

m_cls_profs <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval 
             + cls_students + cls_level + cls_credits + bty_avg, data = evals)
summary(m_cls_profs)$adj.r.squared

m_cls_students <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval 
             + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m_cls_students)$adj.r.squared

m_rank <- lm(score ~ ethnicity + gender + language + age + cls_perc_eval 
             + cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m_rank)$adj.r.squared