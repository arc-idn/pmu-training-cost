# Tables and one chart.
r <- readRDS("outputs/projection.rds")
write.csv(r$proj, "outputs/projection_2025_2030.csv", row.names = FALSE)
png("outputs/projection.png", width = 1600, height = 900, res = 160)
par(mar = c(4.5, 5, 2, 1))
cols <- c("Base" = "#1E3A5F", "High utilisation" = "#C8811A", "Cost containment" = "#6B7280")
plot(NA, xlim = range(c(r$hist$year, r$proj$year)), ylim = c(0, max(r$proj$cost_tn) * 1.1),
     xlab = "Year", ylab = "Rp trillion", main = "JKN cost and revenue (DUMMY DATA)")
lines(r$hist$year, r$hist$cost_total_tn, lwd = 2); lines(r$hist$year, r$hist$revenue_tn, lwd = 2, lty = 2)
for (s in names(cols)) { p <- r$proj[r$proj$scenario == s, ]; lines(p$year, p$cost_tn, col = cols[s], lwd = 2) }
lines(r$proj$year[r$proj$scenario == "Base"], r$proj$revenue_tn[r$proj$scenario == "Base"], lty = 2, lwd = 2)
legend("topleft", c("Cost, history", "Revenue (dashed)", paste("Cost:", names(cols))), col = c("black", "black", cols),
       lty = c(1, 2, 1, 1, 1), lwd = 2, bty = "n")
dev.off()
print(round(r$growth, 4)); print(head(r$proj))
