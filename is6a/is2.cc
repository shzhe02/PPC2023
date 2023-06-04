                // loop rectangle pos
                for (int y0 = 0; y0 <= ny - height; y0++) {
                    int y1 = y0 + height;
                    int na = (nnx - wigth) / 8;                     //  vectors per input row - rectangle wight

                    for (int n = 0; n < na; n++) {
                        int x0 = n * 8;
                        int x1 = x0 + wigth;

                        float8_t s1 = _mm256_loadu_ps(sums.data() + x1 + nnx * y1);     // sums[x1 + nnx * y1]
                        float8_t s2 = _mm256_loadu_ps(sums.data() + x1 + nnx * y0);     // sums[x1 + nnx * y0]
                        float8_t s3 = _mm256_loadu_ps(sums.data() + x0 + nnx * y1);     // sums[x0 + nnx * y1]
                        float8_t s4 = _mm256_loadu_ps(sums.data() + x0 + nnx * y0);     // sums[x0 + nnx * y0]

                        float8_t inner = s1 - s2 - s3 + s4;
                        float8_t outer = vSumAll - inner;

                        float8_t vCost = (inner*inner)*inner_Inv + (outer*outer)*outer_Inv;

                        v_local_best_cost = get_v_max(vCost, v_local_best_cost);
                    }

                    // Calculate remaining with scalar operations
                    for (int x0 = 8 * na; x0 <= nx - wigth; x0++) {
                        int x1 = x0 + wigth;

                        float inner = sums[x1 + nnx * y1]- sums[x0 + nnx * y1] 
                            - sums[x1 + nnx * y0] + sums[x0 + nnx * y0];
                        
                        float outer = sumAll - inner;

                        float cost = (inner*inner)*inner_Inv + (outer*outer)*outer_Inv;

                        local_best_cost = cost > local_best_cost ? cost : local_best_cost;
                    }
                }